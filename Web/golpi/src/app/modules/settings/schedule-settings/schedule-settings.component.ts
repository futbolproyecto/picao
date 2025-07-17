// Core
import { CommonModule } from '@angular/common';
import { Component, DestroyRef, inject, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { finalize } from 'rxjs';

// Librerias
import { FullCalendarModule } from '@fullcalendar/angular';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { NgSelectModule } from '@ng-select/ng-select';
import { DateSelectArg, EventClickArg } from '@fullcalendar/core';

import interactionPlugin from '@fullcalendar/interaction';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import esLocale from '@fullcalendar/core/locales/es';

// Compartidos
import { CardComponent } from '../../../shared/components/custom/card/card.component';
import { Constant } from '../../../shared/utils/constant';

// Services
import { ScheduleService } from '../../../core/service/schedule.service';
import { AlertsService } from '../../../core/service/alerts.service';
import { EstablishmentService } from '../../../core/service/establishment.service';
import { AgendaService } from '../../../core/service/agenda.service';
import { BusyService } from '../../../core/busy.service';

// Componentes
import { ModalScheduleSettingsComponent } from './modal-schedule-settings/modal-schedule-settings.component';

// Dto
import { EstablishmentRequestDto } from '../../../data/schema/establishmentRequestDto';
import { MessageExceptionDto } from '../../../data/schema/MessageExceptionDto';
import { AgendaDto } from '../../../data/schema/agendaDto';
import { FieldRequestDto } from '../../../data/schema/fieldRequestDTO';
import { FieldService } from '../../../core/service/field.service';

@Component({
  selector: 'app-schedule-settings',
  standalone: true,
  imports: [
    CommonModule,
    FullCalendarModule,
    CardComponent,
    MatDialogModule,
    ReactiveFormsModule,
    FormsModule,
    NgSelectModule,
  ],
  templateUrl: './schedule-settings.component.html',
  styleUrl: './schedule-settings.component.css',
})
export class ScheduleSettingsComponent implements OnInit {
  private establishmentService = inject(EstablishmentService);
  private fieldService = inject(FieldService);
  private alertsService = inject(AlertsService);
  private destroyRef = inject(DestroyRef);
  private busyService = inject(BusyService);
  private agendaService = inject(AgendaService);

  public formularioAgenda: UntypedFormGroup = new UntypedFormGroup({});
  private formBuilder = inject(UntypedFormBuilder);

  public establishmentDto: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();
  public fieldtDto: Array<FieldRequestDto> = new Array<FieldRequestDto>();
  public agendaDto: AgendaDto = new AgendaDto();
  public establishmentError: string = '';
  public calendarEvents: any[] = [];

  constructor(private dialog: MatDialog) {
    this.buildForm();
  }

  ngOnInit() {
    this.cargarEstablecimientosUsuario();

    this.formularioAgenda.get('establishment')?.valueChanges.subscribe((id) => {
      this.cargarCanchasEstablecimiento();
    });

    this.formularioAgenda.get('field')?.setValue(0);

    const idEstablecimiento = localStorage.getItem(
      'establecimientoSeleccionado'
    );

    if (idEstablecimiento) {
      const id = idEstablecimiento;
      this.formularioAgenda.get('establishment')?.setValue(id);

      this.cargarDisponibilidad(id);
    } else {
      this.formularioAgenda.get('establishment')?.setValue(null);
    }
  }

  cargarEstablecimientosUsuario(): void {
    const authDataString = sessionStorage.getItem('authentication');
    if (authDataString) {
      const authData = JSON.parse(authDataString);
      const usuarioId = authData.id;

      if (usuarioId !== 0) {
        this.establishmentService
          .establecimientoPorUsuario(usuarioId)
          .subscribe({
            next: (response) => {
              const opcionDefault = { id: 0, name: 'Seleccione...' };

              this.establishmentDto = [
                opcionDefault,
                ...(response?.payload as EstablishmentRequestDto[]),
              ];
            },
            error: (err) => {
              const errorDto = new MessageExceptionDto({
                status: err.error?.status,
                error: err.error?.error,
                recommendation: err.error?.recommendation,
              });
              this.alertsService.fireError(errorDto);
            },
          });
      }
    }
  }

  cargarCanchasEstablecimiento() {
    const establishmentId = this.formularioAgenda.get('establishment')?.value;

    if (!establishmentId) return;

    this.fieldService.canchaPorEstablecimiento(establishmentId).subscribe({
      next: (response) => {
        const opcionDefault = { id: 0, name: 'Seleccione...' };
        this.fieldtDto = [opcionDefault, ...(response?.payload ?? [])];
      },
      error: (err) => {
        const errorDto = new MessageExceptionDto({
          status: err.error?.status,
          error: err.error?.error,
          recommendation: err.error?.recommendation,
        });
        this.alertsService.fireError(errorDto);
      },
    });
  }

  buildForm(): void {
    this.formularioAgenda = this.formBuilder.group({
      establishment: ['', Validators.required],
      field: ['', Validators.required],
    });
  }

  get establishment(): AbstractControl {
    return this.formularioAgenda.get('establishment')!;
  }

  get field(): AbstractControl {
    return this.formularioAgenda.get('fields')!;
  }

  validarEstablecimiento(): boolean {
    let status = false;
    if (this.establishment.touched) {
      if (this.establishment.hasError('required')) {
        this.establishmentError = Constant.ERROR_CAMPO_ESTABLECIMIENTO;
        status = true;
      }
    }
    return status;
  }

  calendarOptions: any = {
    plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
    initialView: 'timeGridWeek',
    locale: esLocale,
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay',
    },
    allDaySlot: false,
    slotMinTime: '06:00:00',
    slotMaxTime: '23:00:00',
    slotDuration: '01:00:00',
    snapDuration: '01:00:00',
    events: this.calendarEvents,
    selectable: true,
    selectMirror: true,

    select: (selectInfo: DateSelectArg) => {
      this.abrirModalNuevaAgenda(selectInfo);
    },

    eventClick: (info: EventClickArg) => {
      if (info.event.extendedProps['isBackground']) return;

      const estado = info.event.extendedProps['estado'];
      if (estado !== 'DISPONIBLE') return;

      this.abrirModal(info);
    },
  };

  abrirModalNuevaAgenda(selectInfo: any) {
    const startDate = new Date(selectInfo.startStr);
    const endDate = new Date(selectInfo.endStr);

    const formatDate = (date: Date): string => {
      const day = String(date.getDate()).padStart(2, '0');
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const year = date.getFullYear();
      return `${day}-${month}-${year}`;
    };

    const formatTime = (date: Date): string => {
      const hours = String(date.getHours()).padStart(2, '0');
      const minutes = String(date.getMinutes()).padStart(2, '0');
      const seconds = String(date.getSeconds()).padStart(2, '0');
      return `${hours}:${minutes}:${seconds}`;
    };

    const daysOfWeek = [
      'domingo',
      'lunes',
      'martes',
      'miércoles',
      'jueves',
      'viernes',
      'sábado',
    ];
    const dayName = daysOfWeek[startDate.getDay()];

    const dialogRef = this.dialog.open(ModalScheduleSettingsComponent, {
      disableClose: true,
      width: '700px',
      data: {
        startDate: formatDate(startDate),
        endDate: formatDate(endDate),
        startTime: formatTime(startDate),
        endTime: formatTime(endDate),
        dayName: dayName,
      },
    });

    dialogRef.afterClosed().subscribe(() => {
      const idEstablecimiento = localStorage.getItem(
        'establecimientoSeleccionado'
      );
      this.cargarDisponibilidad(idEstablecimiento!);
    });
  }

  cargarDisponibilidad(establishmentId: string) {
    this.busyService.busy();
    this.agendaService
      .cargarDisponibilidad(establishmentId!)
      .pipe(
        takeUntilDestroyed(this.destroyRef),
        finalize(() => {
          this.busyService.idle();
        })
      )
      .subscribe((response) => {
        const reservas = response.payload;

        const eventos = reservas.map((reserva: any) => {
          const startDateTime = `${reserva.date}T${reserva.start_time}`;

          return {
            title: `Cancha: ${reserva.status}`,
            start: startDateTime,
            color: this.obtenerColorPorEstado(reserva.status),
            textColor: 'white',
            extendedProps: {
              date: reserva.date,
              fee: reserva.fee,
              start_time: reserva.start_time,
              id: reserva.id,
              estado: reserva.status,
              name_field: reserva.name_field,
            },
          };
        });

        this.calendarOptions.events = eventos;
      });
  }

  buscarDisponibilidad() {
    const establishmentId = this.establishment.value;

    this.busyService.busy();
    this.agendaService
      .cargarDisponibilidad(establishmentId!)
      .pipe(
        takeUntilDestroyed(this.destroyRef),
        finalize(() => {
          this.busyService.idle();
        })
      )
      .subscribe((response) => {
        const reservas = response.payload;

        const eventos = reservas.map((reserva: any) => {
          const startDateTime = `${reserva.date}T${reserva.start_time}`;

          return {
            title: `Cancha: ${reserva.status}`,
            start: startDateTime,
            color: '#5cb85c',
            textColor: 'black',
            extendedProps: {
              date: reserva.date,
              fee: reserva.fee,
              start_time: reserva.start_time,
              id: reserva.id,
              estado: reserva.status,
              cancha: reserva.court,
            },
          };
        });

        this.calendarOptions.events = eventos;
      });
  }

  abrirModal(selectInfo: any) {
    const event = selectInfo.event;

    const startDate = new Date(event.start);
    const endDate = new Date(event.end || event.start);

    const formatDate = (date: Date): string => {
      const day = String(date.getDate()).padStart(2, '0');
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const year = date.getFullYear();
      return `${day}-${month}-${year}`;
    };

    const formatTime = (date: Date): string => {
      const hours = String(date.getHours()).padStart(2, '0');
      const minutes = String(date.getMinutes()).padStart(2, '0');
      const seconds = String(date.getSeconds()).padStart(2, '0');
      return `${hours}:${minutes}:${seconds}`;
    };

    const daysOfWeek = [
      'domingo',
      'lunes',
      'martes',
      'miércoles',
      'jueves',
      'viernes',
      'sábado',
    ];
    const dayName = daysOfWeek[startDate.getDay()];

    const dialogRef = this.dialog.open(ModalScheduleSettingsComponent, {
      disableClose: true,
      width: '700px',
      data: {
        startDate: formatDate(startDate),
        endDate: formatDate(endDate),
        startTime: formatTime(startDate),
        endTime: formatTime(endDate),
        dayName: dayName,
        id: event.extendedProps.id,
        estado: event.extendedProps.estado,
        fee: event.extendedProps.fee,
        cancha: event.extendedProps.cancha || event.extendedProps.name_field,
      },
    });

    dialogRef.afterClosed().subscribe(() => {
      const idEstablecimiento = localStorage.getItem(
        'establecimientoSeleccionado'
      );
      this.cargarDisponibilidad(idEstablecimiento!);
    });
  }

  obtenerColorPorEstado(estado: string): string {
    switch (estado) {
      case 'DISPONIBLE':
        return '#28a745';
      default:
        return '#6c757d';
    }
  }
}

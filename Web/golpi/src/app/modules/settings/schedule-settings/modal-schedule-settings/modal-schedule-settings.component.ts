import { CommonModule } from '@angular/common';
import {
  Component,
  DestroyRef,
  ElementRef,
  inject,
  Inject,
  OnInit,
} from '@angular/core';
import {
  AbstractControl,
  FormArray,
  FormControl,
  FormGroup,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { Constant } from '../../../../shared/utils/constant';
import { EstablishmentRequestDto } from '../../../../data/schema/establishmentRequestDto';
import { EstablishmentService } from '../../../../core/service/establishment.service';
import { MessageExceptionDto } from '../../../../data/schema/MessageExceptionDto';
import { AlertsService } from '../../../../core/service/alerts.service';
import { filter, finalize, switchMap } from 'rxjs';
import { FieldService } from '../../../../core/service/field.service';
import { NgSelectModule } from '@ng-select/ng-select';
import {
  MatCheckboxChange,
  MatCheckboxModule,
} from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { BlockadeService } from '../../../../core/service/blockade.service';
import { BusyService } from '../../../../core/busy.service';
import { ScheduleRequestDto } from '../../../../data/schema/scheduleRequestDto';

import * as rrule from 'rrule';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { MatIcon } from '@angular/material/icon';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { MatSortModule } from '@angular/material/sort';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ValidatorsCustom } from '../../../../shared/utils/validators';
import { MatCard, MatCardTitle } from '@angular/material/card';
import { AgendaService } from '../../../../core/service/agenda.service';

type FrecuenciaTipo = 'DAILY' | 'WEEKLY' | 'MONTHLY' | 'YEARLY';

const frecuenciaMap: Record<FrecuenciaTipo, rrule.Frequency> = {
  DAILY: rrule.RRule.DAILY,
  WEEKLY: rrule.RRule.WEEKLY,
  MONTHLY: rrule.RRule.MONTHLY,
  YEARLY: rrule.RRule.YEARLY,
};

@Component({
  selector: 'app-modal-schedule-settings',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    NgSelectModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatTableModule,
    MatSortModule,
    MatInputModule,
    MatTooltipModule,
    MatIcon,
    MatCard,
  ],
  templateUrl: './modal-schedule-settings.component.html',
  styleUrl: './modal-schedule-settings.component.css',
})
export class ModalScheduleSettingsComponent implements OnInit {
  private formBuilder = inject(UntypedFormBuilder);
  public formularioHorarios: UntypedFormGroup = new UntypedFormGroup({});
  public establishmentError: string = '';
  public canchaError: string = '';
  public diaSemana: string = '';

  private establishmentService = inject(EstablishmentService);
  private alertsService = inject(AlertsService);
  private fieldService = inject(FieldService);
  private agendaService = inject(AgendaService);
  private destroyRef = inject(DestroyRef);
  private busyService = inject(BusyService);
  public fechaInicio: Date = new Date();
  public fechaFin: Date = new Date();
  private element = inject(ElementRef);

  public diasSemana = [
    { codigo: 'MO', nombre: 'L' },
    { codigo: 'TU', nombre: 'M' },
    { codigo: 'WE', nombre: 'M' },
    { codigo: 'TH', nombre: 'J' },
    { codigo: 'FR', nombre: 'V' },
    { codigo: 'SA', nombre: 'S' },
    { codigo: 'SU', nombre: 'D' },
  ];

  public diasSeleccionados: string[] = [];
  public mostrarDiasPersonalizados = false;
  public tarifaFormateado = '$0';

  public listaCanchas: any[] = [];
  public establishmentDto: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();
  public scheduleRequestDto: ScheduleRequestDto = new ScheduleRequestDto();

  public horasDisponibles: string[] = [];
  public horariosValor: any[] = [];
  public dataSource = new MatTableDataSource<any>();

  //Tabla seguimiento agregado
  public columnas: string[] = ['hora_inicio', 'hora_fin', 'tarifa', 'acciones'];
  public bloquearFechaFin = true;

  constructor(
    private dialogRef: MatDialogRef<ModalScheduleSettingsComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      startDate: string;
      endDate: string;
      startTime: string;
      endTime: string;
      dayName: string;
    }
  ) {
    this.buildForm();
  }

  ngOnInit() {
    this.cargarEstablecimientosUsuario();
    this.cargarCanchasEstablecimiento();
    this.generarHoras();
    this.escucharCambiosFechaInicio();

    this.diaSemana = this.data.dayName;

    const [day, month, year] = this.data.startDate.split('-');
    const fecha_inicio = new Date(+year, +month - 1, +day);

    const [dayFin, monthFin, yearFin] = this.data.endDate.split('-');
    const fecha_fin = new Date(+yearFin, +monthFin - 1, +dayFin);

    this.formularioHorarios.get('fecha_inicio')?.setValue(fecha_inicio);
    this.formularioHorarios.get('fecha_fin')?.setValue(fecha_fin);
    this.fechaInicio = fecha_inicio;
    this.fechaFin = fecha_fin;

    this.formularioHorarios.get('formularioValores')?.patchValue({
      hora_inicio: this.data.startTime,
      hora_fin: this.data.endTime,
    });

    const fechaFinControl = this.formularioHorarios.get('fecha_fin');
    fechaFinControl?.disable();

    this.formularioHorarios.get('establishment')?.setValue(0);
  }

  generarHoras(): void {
    const horas = [];
    for (let i = 0; i < 24; i++) {
      const hora = i.toString().padStart(2, '0');
      const horaFormateada = `${hora}:00:00`;
      horas.push(horaFormateada);
    }
    this.horasDisponibles = horas;
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
    this.formularioHorarios
      .get('establishment')
      ?.valueChanges.pipe(
        filter((id: string) => !!id),
        switchMap((id: string) =>
          this.fieldService.canchaPorEstablecimiento(id)
        )
      )
      .subscribe({
        next: (response) => {
          if (
            !response ||
            !Array.isArray(response.payload) ||
            response.payload.length === 0
          ) {
            this.alertsService.toast(
              'error',
              'Este establecimiento no tiene canchas registradas.'
            );

            return;
          }
          this.listaCanchas = response.payload;
          this.cancha.clear();

          this.listaCanchas.forEach(() => {
            this.cancha.push(new FormControl(false));
          });
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

  escucharCambiosFechaInicio(): void {
  this.formularioHorarios.get('fecha_inicio')?.valueChanges.subscribe((fechaInicio: Date) => {
    const fechaFinControl = this.formularioHorarios.get('fecha_fin');
    const fechaFin = fechaFinControl?.value;

    if (fechaInicio && fechaFin && fechaInicio > fechaFin) {
      fechaFinControl?.setValue(fechaInicio);
    }
  });
}


  buildForm(): void {
    this.formularioHorarios = this.formBuilder.group({
      establishment: [Validators.required],
      cancha: this.formBuilder.array([], Validators.required),
      repetir: ['NONE', Validators.required],
      fecha_inicio: [Validators.required],
      fecha_fin: [Validators.required],
      formularioValores: this.formBuilder.group({
        hora_inicio: [Validators.required],
        hora_fin: [Validators.required],
        tarifa: [0, Validators.required],
      }),
    });
  }

  get establishment(): AbstractControl {
    return this.formularioHorarios.get('establishment')!;
  }

  get cancha(): FormArray {
    return this.formularioHorarios.get('cancha') as FormArray;
  }

  get repetir(): AbstractControl {
    return this.formularioHorarios.get('repetir')!;
  }

  get fecha_inicio(): AbstractControl {
    return this.formularioHorarios.get('fecha_inicio')!;
  }

  get fecha_fin(): AbstractControl {
    return this.formularioHorarios.get('fecha_fin')!;
  }

  get hora_inicio(): AbstractControl {
    return this.formularioHorarios.get('formularioValores.hora_inicio')!;
  }

  get hora_fin(): AbstractControl {
    return this.formularioHorarios.get('formularioValores.hora_fin')!;
  }

  get tarifa(): AbstractControl {
    return this.formularioHorarios.get('formularioValores.tarifa')!;
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

  validarCancha(): boolean {
    if (this.cancha.touched && this.cancha.hasError('required')) {
      this.canchaError = Constant.ERROR_CAMPO_CANCHA;
      return true;
    }
    return false;
  }

  guardarRegistro() {
    if (this.formularioHorarios.valid) {
      const selectedCanchaIds = this.cancha.value
        .map((checked: boolean, i: number) =>
          checked ? this.listaCanchas[i].id : null
        )
        .filter((id: number | null): id is number => id !== null);

      if (selectedCanchaIds.length === 0) {
        this.alertsService.toast(
          'error',
          'Debes seleccionar al menos una cancha.'
        );
        return;
      }

      let rruleString: string | null = null;
      const repetir = this.formularioHorarios.get('repetir')?.value as string;
      const startDate = this.formularioHorarios.get('fecha_inicio')?.value;
      const horaInicio = this.formularioHorarios.get(
        'formularioValores.hora_inicio'
      )?.value;
      const [hour, minute] = horaInicio.split(':').map((v: string) => +v);
      const dtstart = new Date(startDate);
      dtstart.setHours(hour, minute, 0, 0);

      const diasMap: { [key: string]: rrule.Weekday } = {
        MO: rrule.RRule.MO,
        TU: rrule.RRule.TU,
        WE: rrule.RRule.WE,
        TH: rrule.RRule.TH,
        FR: rrule.RRule.FR,
        SA: rrule.RRule.SA,
        SU: rrule.RRule.SU,
      };

      if (repetir && repetir !== 'NONE') {
        if (repetir === 'WEEKDAY') {
          const ruleObject = new rrule.RRule({
            freq: rrule.RRule.WEEKLY,
            byweekday: [
              rrule.RRule.MO,
              rrule.RRule.TU,
              rrule.RRule.WE,
              rrule.RRule.TH,
              rrule.RRule.FR,
            ],
            dtstart,
          });
          rruleString =
            ruleObject
              .toString()
              .split('\n')
              .find((line) => line.startsWith('RRULE:'))
              ?.replace('RRULE:', '') || 'NONE';
        } else if (repetir === 'CUSTOM') {
          if (!this.diasSeleccionados || this.diasSeleccionados.length === 0) {
            this.alertsService.toast(
              'error',
              'Debes seleccionar al menos un día.'
            );
            return;
          }
          const ruleObject = new rrule.RRule({
            freq: rrule.RRule.WEEKLY,
            byweekday: this.diasSeleccionados.map((d) => diasMap[d]),
            dtstart,
          });
          rruleString =
            ruleObject
              .toString()
              .split('\n')
              .find((line) => line.startsWith('RRULE:'))
              ?.replace('RRULE:', '') || 'NONE';
        } else if (repetir === 'WEEKLY') {
          const dias = ['SU', 'MO', 'TU', 'WE', 'TH', 'FR', 'SA'];
          const weekdayString = dias[dtstart.getDay()];
          const weekday = diasMap[weekdayString];

          const ruleObject = new rrule.RRule({
            freq: rrule.RRule.WEEKLY,
            byweekday: [weekday],
            dtstart,
          });

          rruleString =
            ruleObject
              .toString()
              .split('\n')
              .find((line) => line.startsWith('RRULE:'))
              ?.replace('RRULE:', '') || 'NONE';
        }
      }

      if (repetir && repetir !== 'NONE') {
        this.scheduleRequestDto = {
          field_ids: selectedCanchaIds,
          start_date: this.formatDate(this.fecha_inicio.value),
          end_date: this.formatDate(this.fecha_fin.value),
          rule: rruleString!,
          information_schedules: this.horariosValor.map((horarios) => ({
            start_time: horarios.hora_inicio,
            end_time: horarios.hora_fin,
            fee: horarios.tarifa,
          })),
        };
      } else {
        this.scheduleRequestDto = {
          field_ids: selectedCanchaIds,
          start_date: this.formatDate(this.fecha_inicio.value),
          end_date: this.formatDate(this.fecha_fin.value),
          information_schedules: this.horariosValor.map((horarios) => ({
            start_time: horarios.hora_inicio,
            end_time: horarios.hora_fin,
            fee: horarios.tarifa,
          })),
        };
      }

      this.busyService.busy();

      this.agendaService
        .crearAgenda(this.scheduleRequestDto)
        .pipe(
          takeUntilDestroyed(this.destroyRef),
          finalize(() => {
            this.busyService.idle();
          })
        )
        .subscribe({
          next: () => {
            this.alertsService.toast(
              'success',
              'La disponibilidad fue registrada correctamente.'
            );

            this.dialogRef.close();
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
    } else {
      this.formularioHorarios.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  private formatDate(date: Date): string {
    return date.toISOString().split('T')[0];
  }

  cerrar() {
    this.alertsService.fireConfirm(
      'warning',
      '',
      '¿Deseas cerrar este formulario sin guardar los cambios?',
      () => {
        this.dialogRef.close();
      }
    );
  }

  actualizarValorMoneda(event: any) {
    let raw = event.target.value.replace(/[^0-9]/g, '');

    if (raw.length > 8) {
      raw = raw.substring(0, 8);
    }

    const numericValue = parseFloat(raw) || 0;

    this.formularioHorarios
      .get('formularioValores.tarifa')
      ?.setValue(numericValue);

    this.tarifaFormateado = this.formatearNumero(numericValue);
  }

  formatearValor() {
    const tarifa =
      this.formularioHorarios.get('formularioValores.tarifa')?.value || 0;
    this.tarifaFormateado = this.formatearNumero(tarifa);
  }

  formatearNumero(tarifa: number | string): string {
    const valorNumerico = Number(tarifa.toString().replace(/[^\d]/g, '')) || 0;

    return new Intl.NumberFormat('es-CO', {
      style: 'currency',
      currency: 'COP',
      currencyDisplay: 'narrowSymbol',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0,
    }).format(valorNumerico);
  }

  bloquearCaracteresInvalidos(event: KeyboardEvent) {
    const key = event.key;

    const controlKeys = [
      'Backspace',
      'Tab',
      'ArrowLeft',
      'ArrowRight',
      'Delete',
      'Home',
      'End',
    ];

    if (!/^\d$/.test(key) && !controlKeys.includes(key)) {
      event.preventDefault();
    }
  }

  onRepetirChange(valor: string) {
    const fechaFin = this.formularioHorarios.get('fecha_fin');
    const fechaInicio = this.formularioHorarios.get('fecha_inicio')?.value;

    if (valor === 'NONE') {
      this.bloquearFechaFin = true;
      fechaFin?.setValue(fechaInicio);
      fechaFin?.disable();
    } else {
      this.bloquearFechaFin = false;
      fechaFin?.enable();
    }

    this.mostrarDiasPersonalizados = valor === 'CUSTOM';
    if (valor !== 'CUSTOM') {
      this.diasSeleccionados = [];
    }
  }

  toggleDiaSeleccionado(codigo: string, event: MatCheckboxChange): void {
    if (event.checked) {
      this.diasSeleccionados.push(codigo);
    } else {
      this.diasSeleccionados = this.diasSeleccionados.filter(
        (d) => d !== codigo
      );
    }
  }

  agregarHorarios(): void {
    const seguimientoGroup = this.formularioHorarios.get(
      'formularioValores'
    ) as FormGroup;

    if (seguimientoGroup.valid) {
      const tarifaValor = this.tarifa?.value;

      if (tarifaValor === 0) {
        this.alertsService.toast('error', 'Debe asignar una tarifa válida.');
        return;
      }

      const horaInicio = this.hora_inicio?.value;
      const horaFin = this.hora_fin?.value;

      if (this.validarHorarios(horaInicio, horaFin)) {
        this.alertsService.toast('error', 'Ya existe un horario en ese rango.');
        return;
      }

      const nuevoRegistro = {
        hora_inicio: horaInicio,
        hora_fin: horaFin,
        tarifa: tarifaValor,
      };

      this.horariosValor.push(nuevoRegistro);
      this.dataSource.data = [...this.horariosValor];
    } else {
      ValidatorsCustom.validateAllFormFields(seguimientoGroup, this.element);
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  eliminarHorario(element: any): void {
    this.horariosValor = this.horariosValor.filter(
      (horario) => horario !== element
    );
    this.dataSource.data = [...this.horariosValor];
  }

  private validarHorarios(horaInicio: string, horaFin: string): boolean {
    const nuevaInicio = horaInicio;
    const nuevaFin = horaFin;

    return this.horariosValor.some((horario) => {
      const existenteInicio = horario.hora_inicio;
      const existenteFin = horario.hora_fin;

      return nuevaInicio < existenteFin && nuevaFin > existenteInicio;
    });
  }
}

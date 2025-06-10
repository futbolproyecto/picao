import { CommonModule } from '@angular/common';
import {
  AfterViewInit,
  Component,
  DestroyRef,
  inject,
  Inject,
  OnInit,
} from '@angular/core';
import {
  AbstractControl,
  FormArray,
  FormControl,
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
import { filter, switchMap } from 'rxjs';
import { FieldService } from '../../../../core/service/field.service';
import { NgSelectModule } from '@ng-select/ng-select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { BlockadeService } from '../../../../core/service/blockade.service';
import { BusyService } from '../../../../core/busy.service';
import { ScheduleRequestDto } from '../../../../data/schema/scheduleRequestDto';

import * as rrule from 'rrule';

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
  ],
  templateUrl: './modal-schedule-settings.component.html',
  styleUrl: './modal-schedule-settings.component.css',
})
export class ModalScheduleSettingsComponent implements OnInit, AfterViewInit {
  private formBuilder = inject(UntypedFormBuilder);
  public formularioHorarios: UntypedFormGroup = new UntypedFormGroup({});
  public establishmentError: string = '';
  public canchaError: string = '';
  public diaSemana: string = '';

  private establishmentService = inject(EstablishmentService);
  private alertsService = inject(AlertsService);
  private fieldService = inject(FieldService);
  private blockadeService = inject(BlockadeService);
  private destroyRef = inject(DestroyRef);
  private busyService = inject(BusyService);

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
  valorFormateado = '$0';

  public listaCanchas: any[] = [];
  public establishmentDto: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();
  public scheduleRequestDto: Array<ScheduleRequestDto> =
    new Array<ScheduleRequestDto>();

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

    this.diaSemana = this.data.dayName;

    const [day, month, year] = this.data.startDate.split('-');
    const fecha_inicio = new Date(+year, +month - 1, +day);

    const [dayFin, monthFin, yearFin] = this.data.endDate.split('-');
    const fecha_fin = new Date(+yearFin, +monthFin - 1, +dayFin);

    this.formularioHorarios.get('fecha_inicio')?.setValue(fecha_inicio);
    this.formularioHorarios.get('fecha_fin')?.setValue(fecha_fin);
    this.formularioHorarios.get('hora_inicio')?.setValue(this.data.startTime);
    this.formularioHorarios.get('hora_fin')?.setValue(this.data.endTime);

    const valorInicial = this.formularioHorarios.get('valor')?.value || 0;
    this.valorFormateado = this.formatearNumero(valorInicial);
  }

  ngAfterViewInit() {
    const control = this.formularioHorarios.get('valor');
    if (control && (control.value === null || control.value === 0)) {
      control.setValue(0);
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
              const establecimientos = response?.payload ?? [];
              if (establecimientos) {
                this.establishmentDto = establecimientos;
              }
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

  buildForm(): void {
    this.formularioHorarios = this.formBuilder.group({
      establishment: [null, Validators.required],
      cancha: this.formBuilder.array([], Validators.required),
      valor: [0, Validators.required],
      repetir: ['NONE', Validators.required],
      fecha_inicio: [],
      fecha_fin: [],
      hora_inicio: [],
      hora_fin: [],
    });
  }

  get establishment(): AbstractControl {
    return this.formularioHorarios.get('establishment')!;
  }

  get cancha(): FormArray {
    return this.formularioHorarios.get('cancha') as FormArray;
  }

  get valor(): AbstractControl {
    return this.formularioHorarios.get('valor')!;
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
    return this.formularioHorarios.get('hora_inicio')!;
  }

  get hora_fin(): AbstractControl {
    return this.formularioHorarios.get('hora_fin')!;
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

  guardar() {
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
      const horaInicio = this.formularioHorarios.get('hora_inicio')?.value;
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
          rruleString = new rrule.RRule({
            freq: rrule.RRule.WEEKLY,
            byweekday: [
              rrule.RRule.MO,
              rrule.RRule.TU,
              rrule.RRule.WE,
              rrule.RRule.TH,
              rrule.RRule.FR,
            ],
            dtstart,
          }).toString();
        } else if (repetir === 'CUSTOM') {
          if (!this.diasSeleccionados || this.diasSeleccionados.length === 0) {
            this.alertsService.toast(
              'error',
              'Debes seleccionar al menos un día.'
            );
            return;
          }

          rruleString = new rrule.RRule({
            freq: rrule.RRule.WEEKLY,
            byweekday: this.diasSeleccionados.map((d) => diasMap[d]),
            dtstart,
          }).toString();
        } else if (['DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY'].includes(repetir)) {
          const frecuencia = frecuenciaMap[repetir as FrecuenciaTipo];
          rruleString = new rrule.RRule({
            freq: frecuencia,
            dtstart,
          }).toString();
        }
      }

      this.scheduleRequestDto = selectedCanchaIds.map((id: number) => {
        if (repetir && repetir !== 'NONE') {
          return {
            field_id: id,
            start_time: this.hora_inicio.value,
            end_time: this.hora_fin.value,
            fee: this.valor.value,
            day: this.formatDate(this.fecha_inicio.value),
            rrule: rruleString,
          };
        } else {
          return {
            field_id: id,
            start_time: this.hora_inicio.value,
            end_time: this.hora_fin.value,
            fee: this.valor.value,
            start_date: this.formatDate(this.fecha_inicio.value),
            end_date: this.formatDate(this.fecha_fin.value),
          };
        }
      });

      console.log('Información: ', this.scheduleRequestDto);

      //this.busyService.busy();

      // this.blockadeService
      //   .crearBloqueo(this.scheduleRequestDto)
      //   .pipe(
      //     takeUntilDestroyed(this.destroyRef),
      //     finalize(() => {
      //       this.busyService.idle();
      //     })
      //   )
      //   .subscribe({
      //     next: () => {
      //       this.alertsService.toast(
      //         'success',
      //         'Horario configurado exitosamente.'
      //       );
      //     },
      //     error: (err) => {
      //       const errorDto = new MessageExceptionDto({
      //         status: err.error?.status,
      //         error: err.error?.error,
      //         recommendation: err.error?.recommendation,
      //       });
      //       this.alertsService.fireError(errorDto);
      //     },
      //   });

      this.dialogRef.close();
    } else {
      this.formularioHorarios.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  private formatDate(date: Date): string {
    return date.toISOString().split('T')[0];
  }

  cerrar() {
    this.dialogRef.close();
  }

  actualizarValorMoneda(event: any) {
    let raw = event.target.value.replace(/[^0-9]/g, '');

    if (raw.length > 8) {
      raw = raw.substring(0, 8);
    }

    const numericValue = parseFloat(raw) || 0;
    this.formularioHorarios.get('valor')?.setValue(numericValue);
    this.valorFormateado = event.target.value;
  }

  formatearValor() {
    const valor = this.formularioHorarios.get('valor')?.value || 0;
    this.valorFormateado = this.formatearNumero(valor);
  }

  formatearNumero(valor: number | string): string {
    if (!valor) return '$0';
    const stringValue = valor.toString().replace(/[^\d]/g, '');
    const formatted = stringValue.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    return `$${formatted}`;
  }

  onRepetirChange(valor: string) {
    this.mostrarDiasPersonalizados = valor === 'CUSTOM';
    if (valor !== 'CUSTOM') {
      this.diasSeleccionados = [];
    }
  }

  toggleDiaSeleccionado(codigo: string, event: Event) {
    const checked = (event.target as HTMLInputElement).checked;
    if (checked) {
      this.diasSeleccionados.push(codigo);
    } else {
      this.diasSeleccionados = this.diasSeleccionados.filter(
        (d) => d !== codigo
      );
    }
  }
}

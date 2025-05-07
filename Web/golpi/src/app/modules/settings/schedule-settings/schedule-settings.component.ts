import { Component, computed, inject } from '@angular/core';
import { CardComponent } from '../../../shared/components/custom/card/card.component';
import { MatIconModule } from '@angular/material/icon';
import { CommonModule } from '@angular/common';
import { MatInputModule } from '@angular/material/input';
import {
  AbstractControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { NgSelectModule } from '@ng-select/ng-select';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { BusyService } from '../../../core/busy.service';
import { EstablishmentRequestDto } from '../../../data/schema/establishmentRequestDto';
import { filter, map, switchMap } from 'rxjs';
import { MessageExceptionDto } from '../../../data/schema/MessageExceptionDto';
import { EstablishmentService } from '../../../core/service/establishment.service';
import { AutenticacionStoreService } from '../../../core/store/auth/autenticacion-store.service';
import { AlertsService } from '../../../core/service/alerts.service';
import { UsuarioResponseDto } from '../../../data/schema/userResponseDto';
import { FieldService } from '../../../core/service/field.service';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { DataTableComponent } from '../../../shared/components/custom/data-table/data-table.component';
import { MatRadioModule } from '@angular/material/radio';

@Component({
  selector: 'app-schedule-settings',
  standalone: true,
  imports: [
    CardComponent,
    MatIconModule,
    CommonModule,
    MatInputModule,
    ReactiveFormsModule,
    FormsModule,
    NgSelectModule,
    MatCheckboxModule,
    MatDatepickerModule,
    MatNativeDateModule,
    DataTableComponent,
    MatRadioModule,
  ],
  templateUrl: './schedule-settings.component.html',
  styleUrl: './schedule-settings.component.css',
})
export class ScheduleSettingsComponent {
  //Servicios
  private establishmentService = inject(EstablishmentService);
  private fieldService = inject(FieldService);
  private autenticacionStoreService = inject(AutenticacionStoreService);
  private alertsService = inject(AlertsService);

  //Librerias
  private formBuilder = inject(UntypedFormBuilder);
  public formularioHorarioEstablecimiento: UntypedFormGroup =
    new UntypedFormGroup({});

  //Dto
  // public tablaEstablecimientos: Array<EstablishmentRequestDto> =
  //   new Array<EstablishmentRequestDto>();
  public establishmentDto: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();

  public configuracionHorarioActivo: boolean = true;
  public nombrePestana: string = 'Configuracion de horarios';
  public listaCanchas: any[] = [];
  public canchasSeleccionadas: number[] = [];
  public horas: { label: string; value: string }[] = [];
  public diasSeleccionados: string[] = [];

  diasSemana = [
    { nombre: 'Lunes', valor: 'LUNES' },
    { nombre: 'Martes', valor: 'MARTES' },
    { nombre: 'Miércoles', valor: 'MIERCOLES' },
    { nombre: 'Jueves', valor: 'JUEVES' },
    { nombre: 'Viernes', valor: 'VIERNES' },
    { nombre: 'Sábado', valor: 'SABADO' },
    { nombre: 'Domingo', valor: 'DOMINGO' },
  ];

  //Tabla
  public eliminar: boolean = true;
  public edit: boolean = true;
  public horariosTitulo: string = 'horarios';

  public encabezadosEstablecimientos = {
    establishment: 'Establecimiento',
    blocked_courts: 'Canchas bloqueadas',
    lock_period: 'Período de bloqueo',
    blocking_time: 'Hora de bloqueo',
    days_blocking: 'Días de bloqueo',
    acciones: 'Acciones',
  };

  tablaEstablecimientos = [
    {
      establishment: 'GolpiGroup',
      blocked_courts: 'Número1, Número2, Número3, Número4',
      lock_period: '2025-05-07 - 2025-06-07',
      blocking_time: '00:00 - 15:00',
      days_blocking: 'Lunes, Martes, Miercoles, Jueves',
    },
    {
      establishment: 'GolpiGroup2',
      blocked_courts: 'Número1',
      lock_period: '2025-05-05 - 2025-05-25',
      blocking_time: '15:00 - 16:00',
      days_blocking: 'Todos los días',
    },
  ];

  constructor(private busyService: BusyService) {
    this.buildForm();
  }

  ngOnInit() {
    this.generarHoras();
    this.cargarEstablecimientosUsuario();
    this.cargarCanchasEstablecimiento();

    this.tipo_bloqueo.valueChanges.subscribe((valor) => {
      if (valor === '1') {
        this.fecha_inicio.disable();
        this.fecha_fin.disable();
      } else {
        this.fecha_inicio.enable();
        this.fecha_fin.enable();
      }
    });

    const tipoBloqueoActual = this.tipo_bloqueo.value;
    if (tipoBloqueoActual === '1') {
      this.fecha_inicio.disable();
      this.fecha_fin.disable();
    }

    this.tipo_bloqueo.valueChanges.subscribe((valor) => {
      if (valor === '1') {
        this.formularioHorarioEstablecimiento.get('fecha_inicio')?.reset();
        this.formularioHorarioEstablecimiento.get('fecha_fin')?.reset();
      }
    });
  }

  activarPestana(pestana: string): void {
    if (pestana === 'configuracionHorarios') {
      this.nombrePestana = 'Configuracion de horarios';
      this.configuracionHorarioActivo = true;
    }
  }

  buildForm(): void {
    this.formularioHorarioEstablecimiento = this.formBuilder.group({
      establishment: [null, Validators.required],
      cancha: ['', Validators.required],
      tipo_bloqueo: ['', Validators.required],
      fecha_inicio: ['', Validators.required],
      fecha_fin: ['', Validators.required],
      hora_inicio: [null, Validators.required],
      hora_fin: [null, Validators.required],
      dia: [null, Validators.required],
    });
  }

  get establishment(): AbstractControl {
    return this.formularioHorarioEstablecimiento.get('establishment')!;
  }

  get cancha(): AbstractControl {
    return this.formularioHorarioEstablecimiento.get('cancha')!;
  }

  get tipo_bloqueo(): AbstractControl {
    return this.formularioHorarioEstablecimiento.get('tipo_bloqueo')!;
  }

  get fecha_inicio(): AbstractControl {
    return this.formularioHorarioEstablecimiento.get('fecha_inicio')!;
  }

  get fecha_fin(): AbstractControl {
    return this.formularioHorarioEstablecimiento.get('fecha_fin')!;
  }

  get hora_inicio(): AbstractControl {
    return this.formularioHorarioEstablecimiento.get('hora_inicio')!;
  }

  get hora_fin(): AbstractControl {
    return this.formularioHorarioEstablecimiento.get('hora_fin')!;
  }

  get dia(): AbstractControl {
    return this.formularioHorarioEstablecimiento.get('dia')!;
  }

  validarCancha(): boolean {
    let status = false;

    if (this.cancha.invalid && this.cancha.touched) {
      if (this.cancha.hasError('required')) {
        this.alertsService.toast(
          'error',
          'Debes seleccionar al menos una cancha.'
        );
        status = true;
      }
    }

    return status;
  }

  cargarCanchasEstablecimiento() {
    this.formularioHorarioEstablecimiento
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

  cargarEstablecimientosUsuario(): void {
    this.autenticacionStoreService
      .obtenerSesion$()
      .pipe(
        map((usuario: UsuarioResponseDto) => usuario?.id ?? 0),
        filter((id: number) => id !== 0),
        switchMap((id: number) =>
          this.establishmentService.establecimientoPorUsuario(id)
        )
      )
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

  generarHoras() {
    for (let h = 0; h < 24; h++) {
      for (let m = 0; m < 60; m += 15) {
        const hora = this.formatearNumero(h);
        const minuto = this.formatearNumero(m);
        const horaCompleta = `${hora}:${minuto}`;
        this.horas.push({ label: horaCompleta, value: horaCompleta });
      }
    }
  }

  formatearNumero(num: number): string {
    return num < 10 ? '0' + num : num.toString();
  }

  onCheckboxChange(fieldId: number, event: any) {
    if (event.checked) {
      this.canchasSeleccionadas.push(fieldId);
    } else {
      this.canchasSeleccionadas = this.canchasSeleccionadas.filter(
        (id) => id !== fieldId
      );
    }
  }

  alternarSeleccionDias(seleccionarTodos: boolean): void {
    if (seleccionarTodos) {
      this.diasSeleccionados = this.diasSemana.map((dia) => dia.valor);
    } else {
      this.diasSeleccionados = [];
    }
  }

  diaCambio(valor: string, event: any): void {
    if (event.checked) {
      this.diasSeleccionados.push(valor);
    } else {
      this.diasSeleccionados = this.diasSeleccionados.filter(
        (d) => d !== valor
      );
    }
  }

  todosLosDiasSeleccionados(): boolean {
    return this.diasSeleccionados.length === this.diasSemana.length;
  }

  algunosDiasSeleccionados(): boolean {
    return (
      this.diasSeleccionados.length > 0 &&
      this.diasSeleccionados.length < this.diasSemana.length
    );
  }

  guardarHorario() {
    if (this.formularioHorarioEstablecimiento.valid) {
      const fechaInicio =
        this.formularioHorarioEstablecimiento.get('fecha_inicio')?.value;
      const fechaFin =
        this.formularioHorarioEstablecimiento.get('fecha_fin')?.value;
      const horaInicio =
        this.formularioHorarioEstablecimiento.get('hora_inicio')?.value;
      const horaFin =
        this.formularioHorarioEstablecimiento.get('hora_fin')?.value;

      // Validación fechas
      if (
        fechaInicio &&
        fechaFin &&
        new Date(fechaFin) < new Date(fechaInicio)
      ) {
        this.alertsService.toast(
          'error',
          'La fecha de fin debe ser posterior a la fecha de inicio.'
        );
        return;
      }

      if (horaInicio && horaFin) {
        const [hInicio, mInicio] = horaInicio.split(':').map(Number);
        const [hFin, mFin] = horaFin.split(':').map(Number);
        const inicio = hInicio * 60 + mInicio;
        const fin = hFin * 60 + mFin;

        if (fin <= inicio) {
          this.alertsService.toast(
            'error',
            'La hora de fin debe ser posterior a la hora de inicio.'
          );
          return;
        }
      }

      this.alertsService.toast('success', 'Horario bloqueado exitosamente.');
      return;
    }

    Object.values(this.formularioHorarioEstablecimiento.controls).forEach(
      (control) => control.markAsTouched()
    );

    const campo = (nombre: string) =>
      this.formularioHorarioEstablecimiento.get(nombre);

    if (!campo('establishment')?.value) {
      this.alertsService.toast(
        'error',
        'Debes seleccionar un establecimiento.'
      );
      return;
    }

    if (!campo('cancha')?.value || campo('cancha')?.value.length === 0) {
      this.alertsService.toast(
        'error',
        'Debes seleccionar al menos una cancha.'
      );
      return;
    }

    if (!campo('tipo_bloqueo')?.value) {
      this.alertsService.toast(
        'error',
        'Debes seleccionar un tipo de bloqueo.'
      );
      return;
    }

    if (campo('tipo_bloqueo')?.value === '2') {
      if (!campo('fecha_inicio')?.value || !campo('fecha_fin')?.value) {
        this.alertsService.toast(
          'error',
          'Debes seleccionar una fecha de inicio y una fecha de fin.'
        );

        return;
      }
    }

    if (!campo('hora_inicio')?.value || !campo('hora_fin')?.value) {
      this.alertsService.toast(
        'error',
        'Debes seleccionar una hora de inicio y una hora de fin.'
      );
      return;
    }

    if (!campo('dia')?.value || campo('dia')?.value.length === 0) {
      this.alertsService.toast('error', 'Debes seleccionar al menos un día.');
      return;
    }
  }

  eliminarBloqueo(id: number): void {
    this.alertsService.fireConfirm(
      'warning',
      '¿Estás seguro de que deseas eliminar este bloqueo?',
      '',
      () => {
        this.alertsService.toast('success', 'Bloqueo eliminado exitosamente.');
      }
    );
  }
}

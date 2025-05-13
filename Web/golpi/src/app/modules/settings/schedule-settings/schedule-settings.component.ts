import { Component, computed, DestroyRef, inject } from '@angular/core';
import { CardComponent } from '../../../shared/components/custom/card/card.component';
import { MatIconModule } from '@angular/material/icon';
import { CommonModule } from '@angular/common';
import { MatInputModule } from '@angular/material/input';
import {
  AbstractControl,
  FormArray,
  FormControl,
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
import { filter, finalize, map, switchMap } from 'rxjs';
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
import { CreateAgendaRequestDto } from '../../../data/schema/createAgendaRequestDto';
import { AgendaService } from '../../../core/service/agenda.service';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';

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
  private agendaService = inject(AgendaService);
  private destroyRef = inject(DestroyRef);

  //Librerias
  private formBuilder = inject(UntypedFormBuilder);
  public formularioHorarioEstablecimiento: UntypedFormGroup =
    new UntypedFormGroup({});

  //Dto
  // public tablaEstablecimientos: Array<EstablishmentRequestDto> =
  //   new Array<EstablishmentRequestDto>();
  public establishmentDto: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();
  public createAgendaRequestDto: Array<CreateAgendaRequestDto> =
    new Array<CreateAgendaRequestDto>();

  public configuracionHorarioActivo: boolean = true;
  public nombrePestana: string = 'Configuracion de horarios';
  public listaCanchas: any[] = [];
  public canchasSeleccionadas: number[] = [];
  public horas: { label: string; value: string }[] = [];
  public diasSeleccionados: number[] = [];

  diasSemana = [
    { nombre: 'Lunes', valor: 'LUNES', id: 1 },
    { nombre: 'Martes', valor: 'MARTES', id: 2 },
    { nombre: 'Miércoles', valor: 'MIERCOLES', id: 3 },
    { nombre: 'Jueves', valor: 'JUEVES', id: 4 },
    { nombre: 'Viernes', valor: 'VIERNES', id: 5 },
    { nombre: 'Sábado', valor: 'SABADO', id: 6 },
    { nombre: 'Domingo', valor: 'DOMINGO', id: 0 },
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
      blocked_courts: 'Cancha 1',
      lock_period: '2025-05-13 - 2025-06-14',
      blocking_time: '00:00 - 02:00',
      days_blocking: 'Martes',
    },
    // {
    //   establishment: 'GolpiGroup2',
    //   blocked_courts: 'Número1',
    //   lock_period: '2025-05-05 - 2025-05-25',
    //   blocking_time: '15:00 - 16:00',
    //   days_blocking: 'Todos los días',
    // },
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
      cancha: this.formBuilder.array([], Validators.required),
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

  get cancha(): FormArray {
    return this.formularioHorarioEstablecimiento.get('cancha') as FormArray;
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
          this.cancha.clear(); // Limpia checkboxes anteriores

          this.listaCanchas.forEach(() => {
            this.cancha.push(new FormControl(false)); // Un checkbox por cancha
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

  generarHoras() {
    for (let h = 0; h < 24; h++) {
      for (let m = 0; m < 60; m += 60) {
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
      this.diasSeleccionados = this.diasSemana.map((dia) => dia.id);
    } else {
      this.diasSeleccionados = [];
    }
  }

  diaCambio(id: number, event: any): void {
    if (event.checked) {
      this.diasSeleccionados.push(id);
    } else {
      this.diasSeleccionados = this.diasSeleccionados.filter((d) => d !== id);
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
      const fechaInicio = this.fecha_inicio.value;
      const fechaFin = this.fecha_fin.value;
      const horaInicio = this.hora_inicio.value;
      const horaFin = this.hora_fin.value;

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

      const diasSeleccionadosNumeros = this.diasSeleccionados.map((id) => {
        return id;
      });

      const lockDownDays = this.calcularFechasBloqueadas(
        fechaInicio,
        fechaFin,
        diasSeleccionadosNumeros,
        horaInicio,
        horaFin
      );

      if (lockDownDays.length === 0) {
        this.alertsService.toast(
          'error',
          'No se generaron fechas bloqueadas. Verifica los días seleccionados.'
        );
        return;
      }

      const requestPayload = selectedCanchaIds.map((id: number) => ({
        field_id: id,
        lock_down_day: lockDownDays,
      }));

      console.log('Payload a enviar:', requestPayload);
      this.busyService.busy();

      this.agendaService
        .crearBloqueo(requestPayload)
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
              'Horario bloqueado exitosamente.'
            );
            this.limpiarFormulario();
            this.cargarEstablecimientosUsuario();
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
      this.validarFormulario();
    }
  }

  calcularFechasBloqueadas(
    fechaInicio: Date,
    fechaFin: Date,
    diasSeleccionados: number[],
    horaInicio: string,
    horaFin: string
  ) {
    const fechasBloqueadas = [];
    let currentFecha = new Date(fechaInicio);

    currentFecha.setUTCHours(0, 0, 0, 0);
    const fechaFinUTC = new Date(fechaFin);
    fechaFinUTC.setUTCHours(23, 59, 59, 999);

    while (currentFecha <= fechaFinUTC) {
      const diaDeLaSemana = currentFecha.getUTCDay();

      if (diasSeleccionados.includes(diaDeLaSemana)) {
        const fechaBloqueada = {
          day: currentFecha.toISOString().split('T')[0],
          start_time: horaInicio,
          end_time: horaFin,
        };
        fechasBloqueadas.push(fechaBloqueada);
      }

      currentFecha.setUTCDate(currentFecha.getUTCDate() + 1);
    }

    return fechasBloqueadas;
  }

  // eliminarBloqueo(id: number): void {
  //   this.alertsService.fireConfirm(
  //     'warning',
  //     '¿Estás seguro de que deseas eliminar este bloqueo?',
  //     '',
  //     () => {
  //       this.alertsService.toast('success', 'Bloqueo eliminado exitosamente.');
  //     }
  //   );
  // }

  limpiarFormulario(): void {
    this.diasSeleccionados = [];
    this.formularioHorarioEstablecimiento.reset();
  }

  //Mensajes de error cuando los datos estan
  validarFormulario() {
    const campo = (nombre: string) =>
      this.formularioHorarioEstablecimiento.get(nombre);

    if (!campo('establishment')?.value) {
      this.alertsService.toast(
        'error',
        'Debes seleccionar un establecimiento.'
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
}

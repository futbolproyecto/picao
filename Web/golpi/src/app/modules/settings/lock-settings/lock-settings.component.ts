import { Component, DestroyRef, inject, OnInit } from '@angular/core';
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
import { filter, finalize, switchMap } from 'rxjs';
import { MessageExceptionDto } from '../../../data/schema/MessageExceptionDto';
import { EstablishmentService } from '../../../core/service/establishment.service';
import { AlertsService } from '../../../core/service/alerts.service';
import { FieldService } from '../../../core/service/field.service';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { DataTableComponent } from '../../../shared/components/custom/data-table/data-table.component';
import { MatRadioModule } from '@angular/material/radio';
import { BlockadeRequestDto } from '../../../data/schema/blockadeRequestDto';
import { BlockadeService } from '../../../core/service/blockade.service';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { EstablishmentResponseDto } from '../../../data/schema/establishmentResponseDto';
import { DatosTablaHorariosDto } from '../../../data/schema/datosTablaHorariosDto';
import { Constant } from '../../../shared/utils/constant';
import { UpdateBlockadeRequestDto } from '../../../data/schema/updateBlockadeRequestDto';

@Component({
  selector: 'app-lock-settings',
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
  templateUrl: './lock-settings.component.html',
  styleUrl: './lock-settings.component.css',
})
export class LockSettingsComponent implements OnInit {
  //Servicios
  private establishmentService = inject(EstablishmentService);
  private fieldService = inject(FieldService);
  private alertsService = inject(AlertsService);
  private blockadeService = inject(BlockadeService);
  private destroyRef = inject(DestroyRef);

  public fechaActual = new Date();
  public establishmentError: string = '';
  public fechaInicioError: string = '';
  public fechaFinError: string = '';
  public horaInicioError: string = '';
  public horaFinError: string = '';
  public diaError: string = '';
  public canchaError: string = '';

  public modoEdicion: boolean = false;

  //Librerias
  private formBuilder = inject(UntypedFormBuilder);
  public formularioHorarioEstablecimiento: UntypedFormGroup =
    new UntypedFormGroup({});

  //Dto
  public tablaHorarios: DatosTablaHorariosDto[] = [];
  public datosTablaHorariosDto: DatosTablaHorariosDto =
    new DatosTablaHorariosDto();
  public establishmentDto: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();
  public blockadeRequestDto: Array<BlockadeRequestDto> =
    new Array<BlockadeRequestDto>();
  public updateBlockadeRequestDto: UpdateBlockadeRequestDto =
    new UpdateBlockadeRequestDto();
  public configuracionHorarioActivo: boolean = true;
  public nombrePestana: string = 'Configuracion de horarios';
  public listaCanchas: any[] = [];
  public canchasSeleccionadas: number[] = [];
  public horas: { label: string; value: string }[] = [];

  diasSemana = [
    { nombre: 'Lunes', id: 1 },
    { nombre: 'Martes', id: 2 },
    { nombre: 'Miércoles', id: 3 },
    { nombre: 'Jueves', id: 4 },
    { nombre: 'Viernes', id: 5 },
    { nombre: 'Sábado', id: 6 },
    { nombre: 'Domingo', id: 0 },
  ];

  //Tabla
  public eliminar: boolean = true;
  public edit: boolean = true;
  public horariosTitulo: string = 'horarios';
  public idHorario: number = 0;

  public canchaSeleccionadaNombre: string | null = null;

  public encabezadosEstablecimientos = {
    name: 'Establecimiento',
    fields: 'Canchas bloqueadas',
    fecha: 'Período de bloqueo',
    hora: 'Hora de bloqueo',
    diasSemana: 'Días de bloqueo',
    acciones: 'Acciones',
  };

  constructor(private busyService: BusyService) {
    this.buildForm();
  }

  ngOnInit() {
    this.generarHoras();
    this.cargarEstablecimientosUsuario();
    this.cargarCanchasEstablecimiento();
    this.cargarHorarios();
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
      fecha_inicio: ['', Validators.required],
      fecha_fin: ['', Validators.required],
      hora_inicio: [null, Validators.required],
      hora_fin: [null, Validators.required],
      dia: this.formBuilder.array([], Validators.required),
    });
  }

  get establishment(): AbstractControl {
    return this.formularioHorarioEstablecimiento.get('establishment')!;
  }

  get cancha(): FormArray {
    return this.formularioHorarioEstablecimiento.get('cancha') as FormArray;
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

  get dia(): FormArray {
    return this.formularioHorarioEstablecimiento.get('dia') as FormArray;
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

  validarFechaInicio(): boolean {
    let status = false;
    if (this.fecha_inicio.touched) {
      if (this.fecha_inicio.hasError('required')) {
        this.fechaInicioError = Constant.ERROR_CAMPO_FECHA_INICIO;
        status = true;
      }
    }
    return status;
  }

  validarFechaFin(): boolean {
    let status = false;
    if (this.fecha_fin.touched) {
      if (this.fecha_fin.hasError('required')) {
        this.fechaFinError = Constant.ERROR_CAMPO_FECHA_FIN;
        status = true;
      }
    }
    return status;
  }

  validarHoraInicio(): boolean {
    let status = false;
    if (this.hora_inicio.touched) {
      if (this.hora_inicio.hasError('required')) {
        this.horaInicioError = Constant.ERROR_CAMPO_HORA_INICIO;
        status = true;
      }
    }
    return status;
  }

  validarHoraFin(): boolean {
    let status = false;
    if (this.hora_fin.touched) {
      if (this.hora_fin.hasError('required')) {
        this.horaFinError = Constant.ERROR_CAMPO_HORA_FIN;
        status = true;
      }
    }
    return status;
  }

  validarDia(): boolean {
    if (this.dia.touched && this.dia.hasError('required')) {
      this.diaError = Constant.ERROR_CAMPO_DIA;
      return true;
    }
    return false;
  }

  validarCancha(): boolean {
    if (this.cancha.touched && this.cancha.hasError('required')) {
      this.canchaError = Constant.ERROR_CAMPO_CANCHA;
      return true;
    }
    return false;
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
          this.cancha.clear();

          this.listaCanchas.forEach(() => {
            this.cancha.push(new FormControl(false));
          });

          if (this.canchaSeleccionadaNombre) {
            const indicesCanchasSeleccionadas = this.listaCanchas
              .map((c, index) =>
                c.name === this.canchaSeleccionadaNombre ? index : -1
              )
              .filter((index) => index !== -1);

            this.cancha.controls.forEach((control, i) => {
              control.setValue(indicesCanchasSeleccionadas.includes(i));
            });

            // Limpiar después de usar
            this.canchaSeleccionadaNombre = null;
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

  cargarHorarios(): void {
    const authDataString = sessionStorage.getItem('authentication');
    if (authDataString) {
      const authData = JSON.parse(authDataString);
      const usuarioId = authData.id;

      if (usuarioId !== 0) {
        this.blockadeService.bloqueosPorUsuario(usuarioId).subscribe({
          next: (response) => {
            const establecimientos: EstablishmentResponseDto[] =
              response.payload;
            this.tablaHorarios =
              this.formatearHorariosParaTabla(establecimientos);
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

  formatearHorariosParaTabla(
    establecimientos: EstablishmentResponseDto[]
  ): DatosTablaHorariosDto[] {
    const datosTabla: DatosTablaHorariosDto[] = [];

    establecimientos.forEach((establecimiento) => {
      establecimiento.fields?.forEach((cancha: any) => {
        cancha.blockades?.forEach((bloqueo: any) => {
          datosTabla.push({
            id: bloqueo.id,
            name: establecimiento.name ?? '',
            fields: cancha.name ?? '',
            fecha: `${bloqueo.start_date} - ${bloqueo.end_date}`,
            hora: `${bloqueo.start_time?.slice(
              0,
              5
            )} - ${bloqueo.end_time?.slice(0, 5)}`,
            diasSemana: bloqueo.days_of_week?.join(', ') ?? '',
          });
        });
      });
    });
    return datosTabla;
  }

  generarHoras() {
    this.horas = [];
    const s = 0;
    for (let h = 0; h < 24; h++) {
      for (let m = 0; m < 60; m += 30) {
        const hora = this.formatearNumero(h);
        const minuto = this.formatearNumero(m);
        const segundos = this.formatearNumero(s);
        const horaCompleta = `${hora}:${minuto}:${segundos}`;
        this.horas.push({ label: horaCompleta, value: horaCompleta });
      }
    }
  }

  formatearNumero(num: number): string {
    return num < 10 ? '0' + num : num.toString();
  }

  alternarSeleccionDias(seleccionarTodos: boolean): void {
    const diaFormArray = this.dia;

    diaFormArray.clear();

    if (seleccionarTodos) {
      this.diasSemana.forEach((dia) => {
        diaFormArray.push(new FormControl(dia.id));
      });
    }

    diaFormArray.markAsTouched();
  }

  diaCambio(id: number, event: any): void {
    const diaFormArray = this.dia;

    if (event.checked) {
      if (!diaFormArray.value.includes(id)) {
        diaFormArray.push(new FormControl(id));
      }
    } else {
      const index = diaFormArray.controls.findIndex(
        (ctrl) => ctrl.value === id
      );
      if (index !== -1) {
        diaFormArray.removeAt(index);
      }
    }

    diaFormArray.markAsTouched();
  }

  todosLosDiasSeleccionados(): boolean {
    return this.dia.value.length === this.diasSemana.length;
  }

  algunosDiasSeleccionados(): boolean {
    const seleccionados = this.dia.value.length;
    return seleccionados > 0 && seleccionados < this.diasSemana.length;
  }

  diaSeleccionado(id: number): boolean {
    return this.dia.value.includes(id);
  }

  guardarHorario() {
    if (this.formularioHorarioEstablecimiento.valid) {
      const fechaInicio = this.fecha_inicio.value;
      const fechaFin = this.fecha_fin.value;
      const horaInicio = this.hora_inicio.value;
      const horaFin = this.hora_fin.value;
      const diasSeleccionadosNumeros = this.dia.value;
      const fechaInicioDate = new Date(fechaInicio);
      const fechaFinDate = new Date(fechaFin);

      if (fechaFinDate <= fechaInicioDate) {
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

      const lockDownDays = this.calcularFechasBloqueadas(
        fechaInicio,
        fechaFin,
        diasSeleccionadosNumeros
      );

      this.blockadeRequestDto = selectedCanchaIds.map((id: number) => ({
        field_id: id,
        start_time: this.hora_inicio.value,
        end_time: this.hora_fin.value,
        days: lockDownDays,
      }));

      this.busyService.busy();

      if (lockDownDays.length > 0) {
        this.blockadeService
          .crearBloqueo(this.blockadeRequestDto)
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
              this.cargarHorarios();
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
        this.busyService.idle();
        this.alertsService.toast(
          'error',
          'El rango de fechas no incluye ninguno de los días seleccionados.'
        );
      }
    } else {
      this.validarFormulario();
    }
  }

  actualizarHorario() {
    if (!this.formularioHorarioEstablecimiento.valid) {
      this.validarFormulario();
      return;
    }

    const fechaInicio = this.fecha_inicio.value;
    const fechaFin = this.fecha_fin.value;
    const horaInicio = this.hora_inicio.value;
    const horaFin = this.hora_fin.value;
    const diasSeleccionadosNumeros = this.dia.value;

    this.validarCancha();

    const selectedCanchaIds = this.cancha.value
      .map((checked: boolean, i: number) =>
        checked ? this.listaCanchas[i].id : null
      )
      .filter((id: string | null): id is string => id !== null);

    if (selectedCanchaIds.length === 0) {
      this.alertsService.toast(
        'error',
        'Debes seleccionar al menos una cancha.'
      );
      return;
    }

    const fechasBloqueadas = this.calcularFechasBloqueadasActualizar(
      fechaInicio,
      fechaFin,
      diasSeleccionadosNumeros
    );

    if (fechasBloqueadas.length === 0) {
      this.busyService.idle();
      this.alertsService.toast(
        'error',
        'El rango de fechas no incluye ninguno de los días seleccionados.'
      );
      return;
    }

    this.updateBlockadeRequestDto = {
      id: this.idHorario,
      blockades: selectedCanchaIds.map((id: number) => ({
        field_id: id,
        start_time: horaInicio,
        end_time: horaFin,
        days: fechasBloqueadas,
      })),
    };

    this.busyService.busy();

    this.blockadeService
      .updateHorario(this.updateBlockadeRequestDto)
      .pipe(
        takeUntilDestroyed(this.destroyRef),
        finalize(() => this.busyService.idle())
      )
      .subscribe({
        next: () => {
          this.alertsService.toast(
            'success',
            'Horario actualizado exitosamente.'
          );
          this.limpiarFormulario();
          this.cargarHorarios();
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

  calcularFechasBloqueadas(
    fechaInicio: Date,
    fechaFin: Date,
    diasSeleccionados: number[]
  ): string[] {
    const fechasBloqueadas: string[] = [];
    let currentFecha = new Date(fechaInicio);

    currentFecha.setHours(0, 0, 0, 0);
    const fechaFinLocal = new Date(fechaFin);
    fechaFinLocal.setHours(23, 59, 59, 999);

    while (currentFecha <= fechaFinLocal) {
      const diaDeLaSemana = currentFecha.getDay();

      if (diasSeleccionados.includes(diaDeLaSemana)) {
        fechasBloqueadas.push(currentFecha.toISOString().split('T')[0]);
      }

      currentFecha.setDate(currentFecha.getDate() + 1);
    }

    return fechasBloqueadas;
  }

  calcularFechasBloqueadasActualizar(
    fechaInicio: Date,
    fechaFin: Date,
    diasSeleccionados: number[]
  ): string[] {
    const fechasBloqueadas: string[] = [];
    let currentFecha = new Date(fechaInicio);
    currentFecha.setHours(0, 0, 0, 0);
    const fechaFinLocal = new Date(fechaFin);
    fechaFinLocal.setHours(23, 59, 59, 999);

    while (currentFecha <= fechaFinLocal) {
      const diaDeLaSemana = currentFecha.getDay();
      if (diasSeleccionados.includes(diaDeLaSemana)) {
        fechasBloqueadas.push(currentFecha.toISOString().split('T')[0]);
      }
      currentFecha.setDate(currentFecha.getDate() + 1);
    }

    return fechasBloqueadas;
  }

  eliminarBloqueo(id: string): void {
    this.alertsService.fireConfirm(
      'warning',
      '¿Estás seguro de que deseas eliminar este bloqueo?',
      '',
      () => {
        this.busyService.busy();

        this.blockadeService
          .eliminarHorario(id)
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
                'Bloqueo eliminado exitosamente.'
              );
              this.limpiarFormulario();
              this.cargarHorarios();
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
    );
  }

  completarHora(hora: string): string {
    const [h, m] = hora.split(':').map(Number);
    return `${this.formatearNumero(h)}:${this.formatearNumero(m)}`;
  }

  cargarInformacionBloqueo(blockadeId: number): void {
    this.blockadeService.bloqueosPorUsuarioId(blockadeId).subscribe({
      next: (response) => {
        this.limpiarFormulario();
        this.modoEdicion = true;

        const payload =
          Array.isArray(response.payload) && response.payload.length > 0
            ? response.payload[0]
            : null;

        const bloqueo = payload.blockades[0];

        this.idHorario = blockadeId;
        this.canchaSeleccionadaNombre = payload.name;
        this.formularioHorarioEstablecimiento.patchValue({
          establishment: payload.establishment_id,
          fecha_inicio: this.parseFechaSinZona(bloqueo.start_date),
          fecha_fin: this.parseFechaSinZona(bloqueo.end_date),
          hora_inicio: bloqueo.start_time,
          hora_fin: bloqueo.end_time,
        });

        function normalizarTexto(text: string): string {
          return text
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .toUpperCase()
            .trim();
        }

        this.dia.clear();

        if (Array.isArray(bloqueo.days_of_week)) {
          bloqueo.days_of_week.forEach((diaStr: string) => {
            const diaObj = this.diasSemana.find(
              (d) => normalizarTexto(d.nombre) === normalizarTexto(diaStr)
            );
            if (diaObj) {
              this.dia.push(new FormControl(diaObj.id));
            }
          });
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

  limpiarFormulario(): void {
    this.dia.clear();
    this.listaCanchas = [];
    this.formularioHorarioEstablecimiento.reset();
    this.modoEdicion = false;
  }

  //Mensajes de error cuando los datos estan
  validarFormulario() {
    this.formularioHorarioEstablecimiento.markAllAsTouched();
    this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
  }

  validacionesCampos() {
    const fechaInicio = this.fecha_inicio.value;
    const fechaFin = this.fecha_fin.value;
    const horaInicio = this.hora_inicio.value;
    const horaFin = this.hora_fin.value;
    const fechaInicioDate = new Date(fechaInicio);
    const fechaFinDate = new Date(fechaFin);

    if (fechaFinDate <= fechaInicioDate) {
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
  }

  parseFechaSinZona(fecha: string): Date {
    const partes = fecha.split('-');
    const year = Number(partes[0]);
    const month = Number(partes[1]) - 1;
    const day = Number(partes[2]);
    return new Date(year, month, day);
  }
}

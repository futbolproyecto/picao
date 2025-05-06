import { Component, inject } from '@angular/core';
import { CardComponent } from '../../../shared/components/custom/card/card.component';
import { MatIconModule } from '@angular/material/icon';
import { CommonModule } from '@angular/common';
import { MatInputModule } from '@angular/material/input';
import {
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
  ],
  templateUrl: './schedule-settings.component.html',
  styleUrl: './schedule-settings.component.css',
})
export class ScheduleSettingsComponent {
  private establishmentService = inject(EstablishmentService);
  private fieldService = inject(FieldService);
  private autenticacionStoreService = inject(AutenticacionStoreService);
  private alertsService = inject(AlertsService);
  private formBuilder = inject(UntypedFormBuilder);
  public formularioHorarioEstablecimiento: UntypedFormGroup =
    new UntypedFormGroup({});
  public tablaEstablecimientos: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();

  public establishmentDto: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();

  public configuracionHorarioActivo: boolean = true;
  public nombrePestana: string = 'Configuracion de horarios';

  public listaCanchas: any[] = [];
  public canchasSeleccionadas: number[] = [];

  public estado: boolean = true;
  public edit: boolean = true;
  public horariosTitulo: string = 'horarios';

  public horas: { label: string; value: string }[] = [];

  public encabezadosEstablecimientos = {
    name: 'Establecimiento',
    address: 'Canchas bloqueadas',
    mobileNumber: 'Período de bloqueo',
    cityName: 'Hora de bloqueo',
    cityName2: 'Días de bloqueo',
    acciones: 'Acciones',
  };

  constructor(private busyService: BusyService) {
    this.buildForm();
  }

  buildForm(): void {
    this.formularioHorarioEstablecimiento = this.formBuilder.group({
      establishment: [null, Validators.required],
      fecha_inicio: ['', Validators.required],
      fecha_fin: ['', Validators.required],
      hora_inicio: [null, Validators.required],
      hora_fin: [null, Validators.required],
    });
  }

  ngOnInit() {
    this.generarHoras();
    this.cargarEstablecimientosUsuario();

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
              'No se encontraron canchas para este establecimiento.'
            );
            this.listaCanchas = [];
            this.canchasSeleccionadas = [];
            return;
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

  activarPestana(pestana: string): void {
    if (pestana === 'configuracionHorarios') {
      this.nombrePestana = 'Configuracion de horarios';
      this.configuracionHorarioActivo = true;
    }
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

  onCheckboxChange(fieldId: number, event: any) {
    if (event.checked) {
      this.canchasSeleccionadas.push(fieldId);
    } else {
      this.canchasSeleccionadas = this.canchasSeleccionadas.filter(
        (id) => id !== fieldId
      );
    }
  }

  diasSemana = [
    { nombre: 'Lunes', valor: 'LUNES' },
    { nombre: 'Martes', valor: 'MARTES' },
    { nombre: 'Miércoles', valor: 'MIERCOLES' },
    { nombre: 'Jueves', valor: 'JUEVES' },
    { nombre: 'Viernes', valor: 'VIERNES' },
    { nombre: 'Sábado', valor: 'SABADO' },
    { nombre: 'Domingo', valor: 'DOMINGO' },
  ];

  diasSeleccionados: string[] = [];

  onDiaChange(valor: string, event: any): void {
    if (event.checked) {
      this.diasSeleccionados.push(valor);
    } else {
      this.diasSeleccionados = this.diasSeleccionados.filter(
        (d) => d !== valor
      );
    }
  }
}

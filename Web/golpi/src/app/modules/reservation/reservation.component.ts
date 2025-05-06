// Core
import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  AbstractControl,
  FormControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';

// Librerias
import { MatInputModule } from '@angular/material/input';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatIconModule } from '@angular/material/icon';
import { NgSelectModule } from '@ng-select/ng-select';
import { MatDialog } from '@angular/material/dialog';

// Servicios
import { AlertsService } from '../../core/service/alerts.service';

// Compatidos
import { Constant } from '../../shared/utils/constant';
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { DataTableComponent } from '../../shared/components/custom/data-table/data-table.component';

// Componentes
import { ShiftsComponent } from '../shifts/shifts.component';

@Component({
  selector: 'app-reservacion',
  standalone: true,
  imports: [
    CardComponent,
    MatIconModule,
    CommonModule,
    MatInputModule,
    ReactiveFormsModule,
    FormsModule,
    MatDatepickerModule,
    MatNativeDateModule,
    DataTableComponent,
    NgSelectModule,
  ],
  templateUrl: './reservation.component.html',
  styleUrl: './reservation.component.css',
})
export class ReservationComponent implements OnInit {
  private formBuilder = inject(UntypedFormBuilder);
  public formularioReservacion: UntypedFormGroup = new UntypedFormGroup({});
  private alertsService = inject(AlertsService);

  public AdministrarActivo: boolean = true;
  public nombrePestana: string = 'Administrar reservaciones';
  public establecimientoError: string = '';
  public fechaReservaError: string = '';
  public horaInicialError: string = '';
  public submitted = false;

  public confirm: boolean = true;
  public finish: boolean = true;
  public edit: boolean = true;
  public tituloReservacion: string = 'reservaciones';

  myControl = new FormControl('');

  ngOnInit() {
    this.formularioReservacion
      .get('hora_inicial')
      ?.valueChanges.subscribe((hora_inicial) => {
        if (hora_inicial) {
          const hora_final = this.calcularHoraFinal(hora_inicial);
          this.formularioReservacion.patchValue({
            hora_final: hora_final,
          });
        }
      });
  }

  public encabezadosReservacion = {
    id: 'ID',
    fecha: 'fecha',
    hora_inicio: 'Hora inicio',
    hora_fin: 'Hora fin',
    cancha: 'Cancha',
    cliente: 'Cliente',
    estado: 'Estado',
    acciones: 'Acciones',
  };

  tablaReservacion = [
    {
      id: '1',
      fecha: '2024-12-19',
      hora_inicio: '13:00',
      hora_fin: '14:00',
      cancha: '1',
      cliente: 'Andrea Isaza',
      estado: 'Pendiente',
    },
    {
      id: '1',
      fecha: '2024-12-19',
      hora_inicio: '14:00',
      hora_fin: '15:00',
      cancha: '2',
      cliente: 'Alejandro Mira',
      estado: 'Confirmado',
    },
  ];

  constructor(private dialog: MatDialog) {
    this.buildForm();
  }

  buildForm(): void {
    this.formularioReservacion = this.formBuilder.group({
      cancha: [null, [Validators.required]],
      cliente: [],
      hora_inicial: ['', [Validators.required]],
      hora_final: [{ value: '', disabled: true }],
      fecha_reserva: ['', [Validators.required]],
      tipo_cancha: [],
    });
  }

  get establecimiento(): AbstractControl {
    return this.formularioReservacion.get('establecimiento')!;
  }

  get fecha_reserva(): AbstractControl {
    return this.formularioReservacion.get('fecha_reserva')!;
  }

  get hora_inicial(): AbstractControl {
    return this.formularioReservacion.get('hora_inicial')!;
  }

  get tipo_cancha(): AbstractControl {
    return this.formularioReservacion.get('tipo_cancha')!;
  }

  activarPestana(pestana: string): void {
    if (pestana === 'administrar') {
      this.nombrePestana = 'Administrar reservaciones';
      this.AdministrarActivo = true;
    }
  }

  validarEstablecimiento(): boolean {
    let status = false;
    if (this.submitted && this.establecimiento.invalid) {
      this.establecimientoError = Constant.ERROR_CAMPO_REQUERIDO;
      status = true;
    }
    return status;
  }

  validarFechaReserva(): boolean {
    let status = false;
    if (this.submitted && this.fecha_reserva.invalid) {
      this.fechaReservaError = Constant.ERROR_CAMPO_REQUERIDO;
      status = true;
    }
    return status;
  }

  validarHoraInicial(): boolean {
    let status = false;
    if (this.hora_inicial.touched) {
      if (this.hora_inicial.hasError('required')) {
        this.horaInicialError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  limpiarFormulario(): void {
    this.formularioReservacion.reset();
  }

  openDialog(): void {
    this.dialog.open(ShiftsComponent, {
      width: '800px',
      height: '60%',
    });
    this.limpiarFormulario();
  }

  RegistrarTurno(): void {
    if (this.formularioReservacion.valid) {
      console.log('Formulario enviado con éxito');
      this.limpiarFormulario();
    } else {
      this.formularioReservacion.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  calcularHoraFinal(horaInicial: string): string {
    const [hora, minutos] = horaInicial.split(':').map(Number);
    return `${hora + 1}:${minutos.toString().padStart(2, '0')}`;
  }
}

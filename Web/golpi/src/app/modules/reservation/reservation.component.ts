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
import { finalize } from 'rxjs';
import { MessageExceptionDto } from '../../data/schema/MessageExceptionDto';
import { FieldService } from '../../core/service/field.service';
import { BusyService } from '../../core/busy.service';

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
  private fieldService = inject(FieldService);

  public AdministrarActivo: boolean = true;
  public nombrePestana: string = 'Administrar reservaciones';
  public canchaError: string = '';
  public fechaReservaError: string = '';
  public horaInicioError: string = '';
  public horaFinError: string = '';
  public celularError: string = '';
  public submitted = false;

  public horas: { label: string; value: string }[] = [];
  public listaCanchas: any[] = [];
  public tituloReservacion: string = 'reservaciones';

  myControl = new FormControl('');

  ngOnInit() {
    this.cargarCanchaEstablecimiento();
  }

  public encabezadosReservacion = {
    id: 'ID',
    fecha: 'fecha',
    hora_inicio: 'Hora inicio',
    hora_fin: 'Hora fin',
    cancha: 'Cancha',
    cliente: 'Cliente',
    estado: 'Estado',
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

  constructor(private dialog: MatDialog, private busyService: BusyService) {
    this.buildForm();
  }

  buildForm(): void {
    this.formularioReservacion = this.formBuilder.group({
      fecha_reserva: ['', [Validators.required]],
      cancha: [null, [Validators.required]],
      celular_jugador: ['', [Validators.required]],
      hora_inicio: ['', [Validators.required]],
      hora_fin: ['', [Validators.required]],
    });
  }
  get fecha_reserva(): AbstractControl {
    return this.formularioReservacion.get('fecha_reserva')!;
  }

  get cancha(): AbstractControl {
    return this.formularioReservacion.get('cancha')!;
  }

  get celular_jugador(): AbstractControl {
    return this.formularioReservacion.get('celular_jugador')!;
  }

  get hora_inicio(): AbstractControl {
    return this.formularioReservacion.get('hora_inicio')!;
  }

  get hora_fin(): AbstractControl {
    return this.formularioReservacion.get('hora_fin')!;
  }

  activarPestana(pestana: string): void {
    if (pestana === 'administrar') {
      this.nombrePestana = 'Administrar reservaciones';
      this.AdministrarActivo = true;
    }
  }

  validarFechaReserva(): boolean {
    let status = false;
    if (this.submitted && this.fecha_reserva.invalid) {
      this.fechaReservaError = Constant.ERROR_CAMPO_REQUERIDO;
      status = true;
    }
    return status;
  }

  validarCancha(): boolean {
    let status = false;
    if (this.submitted && this.cancha.invalid) {
      this.canchaError = Constant.ERROR_CAMPO_REQUERIDO;
      status = true;
    }
    return status;
  }

  validarCelular(): boolean {
    let status = false;
    if (this.celular_jugador.touched) {
      if (this.celular_jugador.hasError('required')) {
        this.celularError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  cargarCanchaEstablecimiento(): void {
    const idEstablecimiento = localStorage.getItem(
      'establecimientoSeleccionado'
    );

    if (!idEstablecimiento) {
      this.alertsService.toast(
        'error',
        'No se ha seleccionado un establecimiento.'
      );
      return;
    }

    this.busyService.busy();

    this.fieldService
      .canchaPorEstablecimiento(idEstablecimiento)
      .pipe(
        finalize(() => {
          this.busyService.idle();
        })
      )
      .subscribe({
        next: (response) => {
          const canchas = response?.payload ?? [];
          if (canchas) {
            this.listaCanchas = canchas;
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
}

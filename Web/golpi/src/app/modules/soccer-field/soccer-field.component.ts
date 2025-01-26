import { Component, inject } from '@angular/core';
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import { EstablishmentComponent } from '../establishment/establishment.component';
import {
  AbstractControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { DataTableComponent } from '../../shared/components/custom/data-table/data-table.component';
import { Constant } from '../../shared/utils/constant';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { AlertsService } from '../../core/service/alerts.service';
import { NgSelectModule } from '@ng-select/ng-select';

@Component({
  selector: 'app-soccer-field',
  standalone: true,
  imports: [
    CardComponent,
    MatIconModule,
    CommonModule,
    EstablishmentComponent,
    DataTableComponent,
    MatInputModule,
    ReactiveFormsModule,
    MatSelectModule,
    FormsModule,
    NgSelectModule,
  ],
  templateUrl: './soccer-field.component.html',
  styleUrl: './soccer-field.component.css',
})
export class SoccerFieldComponent {
  private formBuilder = inject(UntypedFormBuilder);
  public formularioCancha: UntypedFormGroup = new UntypedFormGroup({});
  private alertsService = inject(AlertsService);

  public registrarCanchaActivo: boolean = false;
  public registrarEstablecimientoActivo: boolean = true;
  public nombrePestana: string = 'Registrar establecimiento';

  public numeroCanchaError: string = '';
  public cantidadJugadoresError: string = '';
  public tipoCanchaError: string = '';
  public establecimientoError: string = '';

  public estado: boolean = true;
  public edit: boolean = true;

  public encabezadosCanchas = {
    id: 'ID',
    numero_cancha: 'No. cancha',
    cantidad_jugadores: 'Cant. jugadores',
    Tipo_cancha: 'Tipo cancha',
    establecimiento: 'Establecimiento',
    acciones: 'Acciones',
  };

  tablaCanchas = [
    {
      id: '1',
      numero_cancha: '5',
      cantidad_jugadores: '8',
      Tipo_cancha: 'Profesional',
      establecimiento: 'Maracana',
    },
    {
      id: '2',
      numero_cancha: '3',
      cantidad_jugadores: '12',
      Tipo_cancha: 'Sala',
      establecimiento: 'Maracana',
    },
  ];

  constructor() {
    this.buildForm();
  }

  buildForm(): void {
    this.formularioCancha = this.formBuilder.group({
      numero_cancha: ['', [Validators.required]],
      cantidad_jugadores: ['', [Validators.required]],
      Tipo_cancha: [null, [Validators.required]],
      establecimiento: [null, [Validators.required]],
    });
  }

  get numero_cancha(): AbstractControl {
    return this.formularioCancha.get('numero_cancha')!;
  }

  get cantidad_jugadores(): AbstractControl {
    return this.formularioCancha.get('cantidad_jugadores')!;
  }

  get Tipo_cancha(): AbstractControl {
    return this.formularioCancha.get('Tipo_cancha')!;
  }

  get establecimiento(): AbstractControl {
    return this.formularioCancha.get('establecimiento')!;
  }

  validarNumeroCancha(): boolean {
    let status = false;
    if (this.numero_cancha.touched) {
      if (this.numero_cancha.hasError('required')) {
        this.numeroCanchaError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarCantidadJugadores(): boolean {
    let status = false;
    if (this.cantidad_jugadores.touched) {
      if (this.cantidad_jugadores.hasError('required')) {
        this.cantidadJugadoresError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarTipoCancha(): boolean {
    let status = false;
    if (this.Tipo_cancha.touched) {
      if (this.Tipo_cancha.hasError('required')) {
        this.tipoCanchaError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarEstablecimiento(): boolean {
    let status = false;
    if (this.establecimiento.touched) {
      if (this.establecimiento.hasError('required')) {
        this.establecimientoError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  activarPestana(pestana: string): void {
    if (pestana === 'registrarEstablecimiento') {
      this.registrarEstablecimientoActivo = true;
      this.registrarCanchaActivo = false;
      this.nombrePestana = 'Registrar establecimiento';
    } else if (pestana === 'registrarCancha') {
      this.registrarEstablecimientoActivo = false;
      this.registrarCanchaActivo = true;
      this.nombrePestana = 'Registrar canchas';
    }
  }

  registrarCancha(): void {
    if (this.formularioCancha.valid) {
      console.log('Se guardo los datos');
      this.limpiarFormulario();
    } else {
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  limpiarFormulario(): void {
    this.formularioCancha.reset();
  }
}

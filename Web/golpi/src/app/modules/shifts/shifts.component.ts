import { CommonModule } from '@angular/common';
import { Component, inject, Inject, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import {
  MAT_DATE_FORMATS,
  MatNativeDateModule,
  NativeDateAdapter,
} from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import {
  MatDialogRef,
  MAT_DIALOG_DATA,
  MatDialogModule,
} from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { Constant } from '../../shared/utils/constant';
import { MAT_DATE_LOCALE, DateAdapter } from '@angular/material/core';
import { AlertsService } from '../../core/service/alerts.service';

export const MY_DATE_FORMATS = {
  parse: {
    dateInput: 'l', // Date input format for parsing
  },
  display: {
    dateInput: 'l', // Date input format for displaying
    monthYearLabel: 'MMM YYYY',
    dateA11yLabel: 'LL',
    monthYearA11yLabel: 'MMMM YYYY',
  },
};

@Component({
  selector: 'app-shifts',
  standalone: true,
  templateUrl: './shifts.component.html',
  styleUrls: ['./shifts.component.css'],
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatDialogModule,
    MatDatepickerModule,
    MatNativeDateModule,
  ],
  providers: [
    { provide: MAT_DATE_LOCALE, useValue: 'en-US' }, // Locale para las fechas
    { provide: DateAdapter, useClass: NativeDateAdapter }, // Adaptador de fechas nativo
    { provide: MAT_DATE_FORMATS, useValue: MY_DATE_FORMATS },
  ],
})
export class ShiftsComponent implements OnInit {
  private formBuilder = inject(UntypedFormBuilder);
  public formularioTurno: UntypedFormGroup = new UntypedFormGroup({});
  private alertsService = inject(AlertsService);

  public fechaError: string = '';
  public horaInicialError: string = '';
  public canchaError: string = '';
  public clienteError: string = '';

  constructor(
    private dialogRef: MatDialogRef<ShiftsComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any
  ) {
    this.buildForm();
  }

  ngOnInit() {
    this.formularioTurno
      .get('horaInicial')
      ?.valueChanges.subscribe((horaInicial) => {
        if (horaInicial) {
          const horaFinal = this.calcularHoraFinal(horaInicial);
          this.formularioTurno.patchValue({
            horafinal: horaFinal,
          });
        }
      });
  }

  buildForm(): void {
    this.formularioTurno = this.formBuilder.group({
      fecha: ['', [Validators.required]],
      horaInicial: ['', [Validators.required]],
      horafinal: [{ value: '', disabled: true }],
      cancha: ['', [Validators.required]],
      cliente: ['', [Validators.required]],
    });
  }

  get fecha(): AbstractControl {
    return this.formularioTurno.get('fecha')!;
  }

  get horaInicial(): AbstractControl {
    return this.formularioTurno.get('horaInicial')!;
  }

  get cancha(): AbstractControl {
    return this.formularioTurno.get('cancha')!;
  }

  get cliente(): AbstractControl {
    return this.formularioTurno.get('cliente')!;
  }

  validarFecha(): boolean {
    let status = false;
    if (this.fecha.touched) {
      if (this.fecha.hasError('required')) {
        this.fechaError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarHoraInicial(): boolean {
    let status = false;
    if (this.horaInicial.touched) {
      if (this.horaInicial.hasError('required')) {
        this.horaInicialError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarCancha(): boolean {
    let status = false;
    if (this.cancha.touched) {
      if (this.cancha.hasError('required')) {
        this.canchaError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarCliente(): boolean {
    let status = false;
    if (this.cliente.touched) {
      if (this.cliente.hasError('required')) {
        this.clienteError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  limpiarFormulario(): void {
    this.formularioTurno.reset();
  }

  guardarTurno(): void {
    if (this.formularioTurno.valid) {
      console.log('Se guardo los datos');
      this.limpiarFormulario();
      const turno = this.formularioTurno.value;
      this.dialogRef.close(turno);
    } else {
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  calcularHoraFinal(horaInicial: string): string {
    const [hora, minutos] = horaInicial.split(':').map(Number);
    return `${hora + 1}:${minutos.toString().padStart(2, '0')}`;
  }
}

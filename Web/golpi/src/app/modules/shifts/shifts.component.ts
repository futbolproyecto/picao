import { CommonModule } from '@angular/common';
import { Component, inject, Inject, OnInit, DestroyRef } from '@angular/core';
import {
  AbstractControl,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import {
  MatDialogRef,
  MAT_DIALOG_DATA,
  MatDialogModule,
} from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { Constant } from '../../shared/utils/constant';
import { AlertsService } from '../../core/service/alerts.service';
import { NgSelectModule } from '@ng-select/ng-select';
import { UsuarioResponseDto } from '../../data/schema/userResponseDto';
import { UserService } from '../../core/service/user.service';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';

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
    MatButtonModule,
    MatDialogModule,
    MatDatepickerModule,
    MatNativeDateModule,
    NgSelectModule,
  ],
  providers: [],
})
export class ShiftsComponent implements OnInit {
  private formBuilder = inject(UntypedFormBuilder);
  private userService = inject(UserService);
  private alertsService = inject(AlertsService);

  public formularioTurno: UntypedFormGroup = new UntypedFormGroup({});
  public usuario: Array<UsuarioResponseDto> = new Array<UsuarioResponseDto>();

  private destroyRef = inject(DestroyRef);

  public fechaError: string = '';
  public horaInicialError: string = '';
  public canchaError: string = '';
  public clienteError: string = '';
  public establecimientoError: string = '';

  constructor(
    private dialogRef: MatDialogRef<ShiftsComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any
  ) {
    this.buildForm();
  }

  ngOnInit() {
    this.mostrarCliente();
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

  mostrarCliente(): void {
    this.userService
      .getAll()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe(
        (res: any) => {
          this.usuario = res.payload as UsuarioResponseDto[];
        },
        (err) => {
          this.alertsService.fireError(err);
        }
      );
  }

  buildForm(): void {
    this.formularioTurno = this.formBuilder.group({
      fecha: ['', [Validators.required]],
      horaInicial: ['', [Validators.required]],
      horafinal: [{ value: '', disabled: true }],
      establecimiento: ['', [Validators.required]],
      cancha: ['', [Validators.required]],
      cliente: [null, [Validators.required]],
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

  get establecimiento(): AbstractControl {
    return this.formularioTurno.get('establecimiento')!;
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

  onClose(): void {
    this.dialogRef.close();
  }
}

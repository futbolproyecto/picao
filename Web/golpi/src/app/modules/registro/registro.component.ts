import { CommonModule } from '@angular/common';
import { Component, inject } from '@angular/core';
import {
  AbstractControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { Constant } from '../../shared/utils/constant';

@Component({
  selector: 'app-registro',
  standalone: true,
  imports: [
    CommonModule,
    MatInputModule,
    MatIconModule,
    MatButtonModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  templateUrl: './registro.component.html',
  styleUrl: './registro.component.css',
})
export class RegistroComponent {
  private formBuilder = inject(UntypedFormBuilder);

  public formularioRegistro: UntypedFormGroup = new UntypedFormGroup({});

  //cadenas para errores
  public nombreError: string = '';
  public celularError: string = '';
  public correoError: string = '';

  constructor() {
    this.buildForm();
  }

  buildForm(): void {
    this.formularioRegistro = this.formBuilder.group({
      nombre: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_4),
          Validators.maxLength(Constant.CAMPO_MAXIMO_50),
        ],
      ],
      celular: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_7),
          Validators.maxLength(Constant.CAMPO_MAXIMO_20),
          Validators.pattern(Constant.PATTERN_NUMEROS),
        ],
      ],
      correo: [
        '',
        [
          Validators.required,
          Validators.email,
          Validators.minLength(Constant.CAMPO_MINIMO_11),
          Validators.maxLength(Constant.CAMPO_MAXIMO_50),
        ],
      ],
    });
  }

  get nombre(): AbstractControl {
    return this.formularioRegistro.get('nombre')!;
  }

  get celular(): AbstractControl {
    return this.formularioRegistro.get('celular')!;
  }

  get correo(): AbstractControl {
    return this.formularioRegistro.get('correo')!;
  }

  validarNombre(): boolean {
    let status = false;
    if (this.nombre.touched) {
      if (this.nombre.hasError('required')) {
        this.nombreError = Constant.ERROR_CAMPO_REQUERIDO_NOMBRE;
        status = true;
      } else if (this.nombre.hasError('minlength')) {
        this.nombreError = Constant.ERROR_CAMPO_MINIMO_4;
        status = true;
      } else if (this.nombre.hasError('maxlength')) {
        this.nombreError = Constant.ERROR_CAMPO_MAXIMO_50;
        status = true;
      }
    }
    return status;
  }

  validarCelular(): boolean {
    let status = false;
    if (this.celular.touched) {
      if (this.celular.hasError('required')) {
        this.celularError = Constant.ERROR_CAMPO_REQUERIDO_CELULAR;
        status = true;
      } else if (this.celular.hasError('minlength')) {
        this.celularError = Constant.ERROR_CAMPO_MINIMO_7;
        status = true;
      } else if (this.celular.hasError('maxlength')) {
        this.celularError = Constant.ERROR_CAMPO_MAXIMO_20;
        status = true;
      } else if (this.celular.hasError('pattern')) {
        this.celularError = Constant.ERROR_CAMPO_SOLO_NUMEROS;
        status = true;
      }
    }
    return status;
  }

  validarCorreo(): boolean {
    let status = false;
    if (this.correo.touched) {
      if (this.correo.hasError('required')) {
        this.correoError = Constant.ERROR_CAMPO_REQUERIDO_CORREO;
        status = true;
      } else if (this.correo.hasError('minlength')) {
        this.correoError = Constant.ERROR_CAMPO_MINIMO_11;
        status = true;
      } else if (this.correo.hasError('maxlength')) {
        this.correoError = Constant.ERROR_CAMPO_MAXIMO_50;
        status = true;
      }
    }
    return status;
  }

  enviar(): void {
    if (this.formularioRegistro.invalid) {
      this.formularioRegistro.markAllAsTouched();
      return;
    }

    console.log('Enviando datos...');
  }
}

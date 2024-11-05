import { Component, inject } from '@angular/core';
import { MatInputModule } from '@angular/material/input';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import {
  AbstractControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Constant } from '../../../shared/utils/constant';
import { RegistroComponent } from '../../registro/registro.component';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [
    CommonModule,
    MatInputModule,
    MatIconModule,
    MatButtonModule,
    FormsModule,
    ReactiveFormsModule,
    RegistroComponent,
  ],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent {
  private formBuilder = inject(UntypedFormBuilder);

  public passVisible: boolean = true;
  public formularioLogin: UntypedFormGroup = new UntypedFormGroup({});

  //cadenas para errores
  public correoError: string = '';
  public passError: string = '';

  constructor() {
    this.buildForm();
  }

  buildForm(): void {
    this.formularioLogin = this.formBuilder.group({
      correo: [
        '',
        [
          Validators.required,
          Validators.email,
          Validators.minLength(Constant.CAMPO_MINIMO_11),
          Validators.maxLength(Constant.CAMPO_MAXIMO_50),
        ],
      ],
      pass: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_CONTRASENA),
          Validators.maxLength(Constant.CAMPO_MAXIMO_CONTRASENA),
        ],
      ],
    });
  }

  get correo(): AbstractControl {
    return this.formularioLogin.get('correo')!;
  }

  get pass(): AbstractControl {
    return this.formularioLogin.get('pass')!;
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

  validarPass(): boolean {
    let status = false;
    if (this.pass.touched) {
      if (this.pass.hasError('required')) {
        this.passError = Constant.ERROR_CAMPO_REQUERIDO_CONTRASENA;
        status = true;
      } else if (this.pass.hasError('minlength')) {
        this.passError = Constant.ERROR_CAMPO_MINIMO_CONTRASENA;
        status = true;
      } else if (this.pass.hasError('maxlength')) {
        this.passError = Constant.ERROR_CAMPO_MAXIMO_CONTRASENA;
        status = true;
      }
    }
    return status;
  }

  passVisibleToogle(): void {
    this.passVisible = !this.passVisible;
  }

  iniciarSesion(): void {
    if (this.formularioLogin.invalid) {
      this.formularioLogin.markAllAsTouched();
      return;
    }

    console.log('Iniciando sesión...');
  }
}

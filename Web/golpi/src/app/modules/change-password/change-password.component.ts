import { CommonModule } from '@angular/common';
import { Component, inject, OnInit } from '@angular/core';
import {
  AbstractControl,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { Constant } from '../../shared/utils/constant';

@Component({
  selector: 'app-change-password',
  standalone: true,
  imports: [CommonModule, MatInputModule, MatIconModule],
  templateUrl: './change-password.component.html',
  styleUrl: './change-password.component.css',
})
export class ChangePasswordComponent implements OnInit {
  private formBuilder = inject(UntypedFormBuilder);
  public formularioPass: UntypedFormGroup = new UntypedFormGroup({});

  public passVisible: boolean = true;
  public passwordError: string = '';
  public passwordNewError: string = '';
  public passwordConfirmError: string = '';

  ngOnInit(): void {
    this.buildForm();
  }

  buildForm(): void {
    this.formularioPass = this.formBuilder.group(
      {
        password: [
          '',
          [
            Validators.required,
            Validators.minLength(Constant.CAMPO_MINIMO_CONTRASENA),
            Validators.maxLength(Constant.CAMPO_MAXIMO_CONTRASENA),
            // ValidatorsCustom.validarSiHayEspacios,
          ],
        ],
        passwordNew: [
          '',
          [
            Validators.required,
            Validators.minLength(Constant.CAMPO_MINIMO_CONTRASENA),
            Validators.maxLength(Constant.CAMPO_MAXIMO_CONTRASENA),
            Validators.pattern(Constant.PATTERN_CONTRASENA),
            // ValidatorsCustom.validarSiHayEspacios,
          ],
        ],
        passwordConfirm: [
          '',
          [
            Validators.required,
            Validators.minLength(Constant.CAMPO_MINIMO_CONTRASENA),
            Validators.maxLength(Constant.CAMPO_MAXIMO_CONTRASENA),
            Validators.pattern(Constant.PATTERN_CONTRASENA),
          ],
        ],
      },
      {
        // validators: ValidatorsCustom.validarQueSeanIguales,
      }
    );
  }

  get password(): AbstractControl {
    return this.formularioPass.get('password')!;
  }

  get passwordNew(): AbstractControl {
    return this.formularioPass.get('passwordNew')!;
  }

  get passwordConfirm(): AbstractControl {
    return this.formularioPass.get('passwordConfirm')!;
  }

  validarPassword(): boolean {
    let status = false;
    if (this.password.dirty) {
      if (this.password.hasError('required')) {
        this.passwordError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      } else if (this.password.hasError('minlength')) {
        this.passwordError = Constant.ERROR_CAMPO_MINIMO_CONTRASENA;
        status = true;
      } else if (this.password.hasError('maxlength')) {
        this.passwordError = Constant.ERROR_CAMPO_MAXIMO_CONTRASENA;
        status = true;
      } else if (this.password.hasError('hayEspacios')) {
        status = false;
      }
    }

    return status;
  }

  passVisibleToogle(): void {
    this.passVisible = !this.passVisible;
  }
}

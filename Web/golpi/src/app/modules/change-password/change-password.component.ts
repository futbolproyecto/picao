// Core
import { CommonModule } from '@angular/common';
import { Component, DestroyRef, inject, OnInit } from '@angular/core';
import {
  AbstractControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';

// Librerias
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';

// Servicios
import { AlertsService } from '../../core/service/alerts.service';

// Comparitdos
import { Constant } from '../../shared/utils/constant';
import { ValidatorsCustom } from '../../shared/utils/validators';
import { MessageExceptionDto } from '../../data/schema/MessageExceptionDto';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { UserService } from '../../core/service/user.service';
import { SetPasswordDto } from '../../data/schema/setPasswordDto';
import { AutenticacionStoreService } from '../../core/store/auth/autenticacion-store.service';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-change-password',
  standalone: true,
  imports: [
    CommonModule,
    MatInputModule,
    MatIconModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  templateUrl: './change-password.component.html',
  styleUrl: './change-password.component.css',
})
export class ChangePasswordComponent implements OnInit {
  public formularioPass: UntypedFormGroup = new UntypedFormGroup({});
  public setPasswordDto: SetPasswordDto = new SetPasswordDto();
  private autenticacionStoreService = inject(AutenticacionStoreService);
  private alertsService = inject(AlertsService);
  private destroyRef = inject(DestroyRef);

  public passVisible: boolean = true;
  public passVisibleNew: boolean = true;
  public passVisibleConfirm: boolean = true;
  public passwordError: string = '';
  public passwordNewError: string = '';
  public passwordConfirmError: string = '';
  public passwordSeguridadError: boolean = false;
  public idUser: number = 0;
  private idUser$: Observable<number>;

  ngOnInit(): void {
    this.buildForm();
    this.idUser$.subscribe((id: number) => {
      this.idUser = id;
    });
  }

  constructor(
    private formBuilder: UntypedFormBuilder,
    private userService: UserService
  ) {
    this.idUser$ = this.autenticacionStoreService.obtenerId$();
  }

  buildForm(): void {
    this.formularioPass = this.formBuilder.group(
      {
        password: [
          '',
          [Validators.required, ValidatorsCustom.validarSiHayEspacios],
        ],
        passwordNew: [
          '',
          [
            Validators.required,
            Validators.minLength(Constant.CAMPO_MINIMO_CONTRASENA),
            Validators.maxLength(Constant.CAMPO_MAXIMO_CONTRASENA),
            Validators.pattern(Constant.PATTERN_CONTRASENA),
            ValidatorsCustom.validarSiHayEspacios,
          ],
        ],
        passwordConfirm: ['', [Validators.required]],
      },
      {
        validators: ValidatorsCustom.validarQueSeanIguales,
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

  //validar campos is-invalid
  validarPasswordCampo(): boolean {
    return this.password.errors !== null && this.password.touched;
  }

  validarPasswordNewCampo(): boolean {
    return this.passwordNew.errors !== null && this.passwordNew.touched;
  }

  validarPasswordConfirmCampo(): boolean {
    return this.passwordConfirm.errors !== null && this.passwordConfirm.touched;
  }
  //validar campos is-invalid

  //validar campos is-valid
  validarPasswordCampoValido(): boolean {
    return this.password.valid;
  }

  validarPasswordNewCampoValido(): boolean {
    return this.passwordNew.valid;
  }

  validarPasswordConfirmCampoValido(): boolean {
    return this.passwordConfirm.valid;
  }

  //validar campos is-valid
  validarPassword(): boolean {
    let status = false;
    if (this.password.touched || this.password.dirty) {
      if (this.password.hasError('required')) {
        this.passwordError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      } else if (this.password.hasError('hayEspacios')) {
        this.passwordError = Constant.ERROR_CAMPO_NO_ESPACIOS;
        status = true;
      }
    }
    return status;
  }

  validarPasswordNew(): boolean {
    let status = false;
    this.passwordNewError = '';
    this.passwordSeguridadError = false;

    const touchedOrDirty = this.passwordNew.touched || this.passwordNew.dirty;
    const value = this.passwordNew.value?.trim();

    if (touchedOrDirty) {
      if (value === '' && this.passwordNew.hasError('required')) {
        this.passwordNewError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      } else if (this.passwordNew.hasError('hayEspacios')) {
        this.passwordNewError = Constant.ERROR_CAMPO_NO_ESPACIOS;
        status = true;
      } else if (this.passwordNew.hasError('pattern')) {
        this.passwordSeguridadError = true;
        status = true;
      }
    }

    return status;
  }

  validarPasswordConfirm(): boolean {
    let status = false;
    this.passwordConfirmError = ''; 

    if (this.passwordConfirm.touched || this.passwordConfirm.dirty) {
      if (this.passwordConfirm.hasError('required')) {
        this.passwordConfirmError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      } else if (this.passwordConfirm.hasError('noSonIguales')) {
        this.passwordConfirmError = Constant.ERROR_CAMPO_CONTRASENA_NO_CONCIDEN;
        status = true;
      }
    }

    return status;
  }

  validarErroresDePolitica(): boolean {
    this.passwordSeguridadError = false;

    if (this.passwordNew.touched || this.passwordNew.dirty) {
      const value = this.passwordNew.value;
      if (
        value &&
        (this.passwordNew.hasError('pattern') ||
          this.passwordNew.hasError('minlength') ||
          this.passwordNew.hasError('maxlength') ||
          this.passwordNew.hasError('hayEspacios'))
      ) {
        this.passwordSeguridadError = true;
        return true;
      }
    }

    return false;
  }

  actualizarPassword(): void {
    if (this.formularioPass.valid) {
      this.setPasswordDto = {
        id_user: this.idUser,
        old_password: this.password.value,
        new_password: this.passwordNew.value,
      };

      this.userService
        .setPassword(this.setPasswordDto)
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe(
          () => {
            this.alertsService.toast(
              'success',
              'Contraseña actualizada existosamente.'
            );

            this.limpiarFormulario();
          },
          (err) => {
            const errorDto = new MessageExceptionDto({
              status: err.error?.status,
              error: err.error?.error,
              recommendation: err.error?.recommendation,
            });
            this.alertsService.fireError(errorDto);
          }
        );
    } else {
      this.formularioPass.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  limpiarFormulario(): void {
    this.formularioPass.reset();
    this.passVisible = true;
  }

  passVisibleToogle(campo_number: number): void {
    switch (campo_number) {
      case 1:
        this.passVisible = !this.passVisible;
        break;
      case 2:
        this.passVisibleNew = !this.passVisibleNew;
        break;
      case 3:
        this.passVisibleConfirm = !this.passVisibleConfirm;
        break;
    }
  }
}

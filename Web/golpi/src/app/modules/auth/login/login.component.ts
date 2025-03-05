// Core
import { Component, DestroyRef, inject } from '@angular/core';
import {
  AbstractControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { Subscription } from 'rxjs';
import { trigger, transition, style, animate } from '@angular/animations';

// Librerias
import { MatInputModule } from '@angular/material/input';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';

// Compartidos
import { Constant } from '../../../shared/utils/constant';
import { MatFormFieldModule } from '@angular/material/form-field';
import { GenericDto } from '../../../core/models/generic-dto';
import { MessageExceptionDto } from '../../../data/schema/MessageExceptionDto';

// Servicios
import { ModoAuthService } from '../../../core/service/modo-auth.service';
import { AuthService } from '../../../core/service/auth.service';
import { AlertsService } from '../../../core/service/alerts.service';
import { UserService } from '../../../core/service/user.service';
import { OtpRequestDto } from '../../../data/schema/otpRequestDto';
import { OtpService } from '../../../core/service/otp.service';
import { LoadingService } from '../../../core/service/loading.service';
import { AutenticacionStoreService } from '../../../core/store/auth/autenticacion-store.service';

// Componentes
import { CarouselComponent } from '../../../shared/components/layout/carousel/carousel.component';
import { RegistreComponent } from '../../registre/registre.component';

// Dto
import { LoginRequestDto } from '../../../data/schema/loginRequestDto';
import { AuthRequestDto } from '../../../data/schema/authRequestDto';

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
    RegistreComponent,
    CarouselComponent,
    MatFormFieldModule,
  ],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  animations: [
    trigger('transitionMessages', [
      transition(':enter', [
        style({ opacity: 0 }),
        animate('300ms', style({ opacity: 1 })),
      ]),
      transition(':leave', [animate('300ms', style({ opacity: 0 }))]),
    ]),
  ],
})
export class LoginComponent {
  public authService = inject(AuthService);
  public userService = inject(UserService);
  public otpService = inject(OtpService);
  public correoVerificacionOtp: OtpRequestDto = new OtpRequestDto();
  private alertsService = inject(AlertsService);
  private subscripcion: Subscription = new Subscription();
  private readonly autenticacionStore = inject(AutenticacionStoreService);
  public usuario: AuthRequestDto = new AuthRequestDto();
  private destroyRef = inject(DestroyRef);

  public passVisible: boolean = true;
  public esModoRegistro: boolean = false;
  public formularioLogin: UntypedFormGroup = new UntypedFormGroup({});
  public loginRequestDto: LoginRequestDto = new LoginRequestDto();
  public loadingService: LoadingService = new LoadingService();

  //cadenas para errores
  public correoError: string = '';
  public passError: string = '';

  constructor(
    private formBuilder: UntypedFormBuilder,
    private ModoAuthService: ModoAuthService,
    private router: Router
  ) {
    this.buildForm();
    this.ModoAuthService.esModoRegistro$.subscribe((modo) => {
      this.esModoRegistro = modo;
    });
  }

  buildForm(): void {
    this.formularioLogin = this.formBuilder.group({
      correo: ['', [Validators.required]],
      pass: ['', [Validators.required]],
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
      }
    }
    return status;
  }

  passVisibleToogle(): void {
    this.passVisible = !this.passVisible;
  }

  cambioModoInicioRegistro() {
    this.ModoAuthService.setModoRegistro(true);
    this.limpiarFormulario();
  }

  limpiarFormulario(): void {
    this.formularioLogin.reset();
  }

  iniciarSesion() {
    if (this.formularioLogin.valid) {
      const usuario: LoginRequestDto = {
        email_or_mobile_number: this.correo?.value,
        password: this.pass?.value,
      };

      this.subscripcion = this.authService.iniciarSesion(usuario).subscribe({
        next: (resp: GenericDto<AuthRequestDto>) => {
          const usuario: AuthRequestDto =
            resp.payload ?? ({} as AuthRequestDto);

          // if (!usuario.roles || !usuario.roles.includes('ADMINISTRADOR')) {
          //   this.alertsService.toast(
          //     'error',
          //     'Acceso restringido: no tienes permisos de administrador'
          //   );
          //   return;
          // }

          this.autenticacionStore.adicionarSesion(usuario);
          this.router.navigate(['/home']);
          this.limpiarFormulario();
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
    } else {
      this.formularioLogin.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  enviarCodigo(event: Event): void {
    event.preventDefault();

    this.alertsService.fireConfirmMail(
      'warning',
      'Restablecer contraseña',
      'Por favor, introduce el correo electrónico asociado a tu cuenta para recuperar tu contraseña.',
      (correoIngresado: string) => {
        const otpRequest = new OtpRequestDto({ email: correoIngresado });

        this.otpService
          .envioEmail(otpRequest)
          .pipe(takeUntilDestroyed(this.destroyRef))
          .subscribe(
            () => {
              this.validarEmail(correoIngresado);
            },
            (err) => {
              const errorDto = new MessageExceptionDto({
                status: err.error?.status,
                error: err.error?.error,
                recommendation: err.error?.recommendation,
              });

              this.alertsService.fireError2(errorDto, () => {
                this.enviarCodigo(event);
              });
            }
          );
      }
    );
  }

  validarEmail(correoIngresado: string): void {
    this.alertsService.fireConfirmCode(
      'question',
      'Código de verificación',
      'Por favor, ingrese el código recibido',
      correoIngresado,
      (correo: string, otp: string) => {
        const otpRequest = new OtpRequestDto({
          email: correo,
          otp: otp,
        });

        this.otpService
          .validarEmail(otpRequest)
          .pipe(takeUntilDestroyed(this.destroyRef))
          .subscribe(
            () => {
              this.cambioPassword(correo, otp);
            },
            (err) => {
              const errorDto = new MessageExceptionDto({
                status: err.error?.status,
                error: err.error?.error,
                recommendation: err.error?.recommendation,
              });

              this.alertsService.fireError2(errorDto, () => {
                this.validarEmail(correoIngresado);
              });
            }
          );
      }
    );
  }

  cambioPassword(correo: string, otp: string): void {
    this.alertsService.fireChangePassword(
      correo,
      otp,
      (email, password, otp) => {
        const changePasswordRequest = {
          email: email,
          password: password,
          otp: otp,
        };

        this.userService
          .envioCodigo(changePasswordRequest)
          .pipe(takeUntilDestroyed(this.destroyRef))
          .subscribe(
            () => {
              this.alertsService.toast(
                'success',
                'Contraseña cambiada correctamente'
              );
            },
            (err) => {
              const errorDto = new MessageExceptionDto({
                status: err.error?.status,
                error: err.error?.error,
                recommendation: err.error?.recommendation,
              });

              this.alertsService.fireError2(errorDto, () => {
                this.cambioPassword(correo, otp);
              });
            }
          );
      }
    );
  }

  ngOnDestroy(): void {
    if (this.subscripcion) {
      this.subscripcion.unsubscribe();
    }
  }
}

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
import { RegistreComponent } from '../../registre/registre.component';
import { ModoAuthService } from '../../../core/service/modo-auth.service';
import { CarouselComponent } from '../../../shared/components/layout/carousel/carousel.component';
import { Router } from '@angular/router';
import { trigger, transition, style, animate } from '@angular/animations';
import { MatFormFieldModule } from '@angular/material/form-field';
import { LoginRequestDto } from '../../../data/schema/loginRequestDto';
import { AuthService } from '../../../core/service/auth.service';
import { NgxSpinnerService } from 'ngx-spinner';
import { finalize, Subscription } from 'rxjs';
import { GenericDto } from '../../../core/models/generic-dto';
import { AuthRequestDto } from '../../../data/schema/authRequestDto';
import { AutenticacionStoreService } from '../../../core/store/auth/autenticacion-store.service';
import { MessageExceptionDto } from '../../../data/schema/MessageExceptionDto';
import { AlertsService } from '../../../core/service/alerts.service';

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
  private alertsService = inject(AlertsService);
  private subscripcion: Subscription = new Subscription();
  private readonly autenticacionStore = inject(AutenticacionStoreService);
  public usuario: AuthRequestDto = new AuthRequestDto();

  public passVisible: boolean = true;
  public esModoRegistro: boolean = false;
  public formularioLogin: UntypedFormGroup = new UntypedFormGroup({});
  public loginRequestDto: LoginRequestDto = new LoginRequestDto();

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
      correo: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_10),
          Validators.maxLength(Constant.CAMPO_MAXIMO_50),
        ],
      ],
      pass: [
        '',
        [
          Validators.required,
          // Validators.minLength(Constant.CAMPO_MINIMO_CONTRASENA),
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
      if (this.correo.hasError('minlength')) {
        this.correoError = Constant.ERROR_CAMPO_MINIMO_10;
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
      }
      // else if (this.pass.hasError('minlength')) {
      //   this.passError = Constant.ERROR_CAMPO_MINIMO_CONTRASENA;
      //   status = true;
      // }
      else if (this.pass.hasError('maxlength')) {
        this.passError = Constant.ERROR_CAMPO_MAXIMO_CONTRASENA;
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
  ngOnDestroy(): void {
    if (this.subscripcion) {
      this.subscripcion.unsubscribe();
    }
  }
}

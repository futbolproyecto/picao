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
import { filter, map, switchMap } from 'rxjs/operators';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';

// Servicios
import { CountryService } from '../../core/service/country.service';
import { UserService } from '../../core/service/user.service';
import { AlertsService } from '../../core/service/alerts.service';
import { AutenticacionStoreService } from '../../core/store/auth/autenticacion-store.service';

// Librerias
import { MatNativeDateModule } from '@angular/material/core';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { NgSelectModule } from '@ng-select/ng-select';

// Compartidos
import { Constant } from '../../shared/utils/constant';
import { MessageExceptionDto } from '../../data/schema/MessageExceptionDto';
import { CardComponent } from '../../shared/components/custom/card/card.component';

// Componentes
import { ChangePasswordComponent } from '../change-password/change-password.component';

//Dto
import { UsuarioResponseDto } from '../../data/schema/userResponseDto';
import { CountryDto } from '../../data/schema/countryDto';

@Component({
  selector: 'app-update-data',
  standalone: true,
  imports: [
    CommonModule,
    MatInputModule,
    MatIconModule,
    MatButtonModule,
    FormsModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatDatepickerModule,
    MatNativeDateModule,
    CardComponent,
    NgSelectModule,
    ChangePasswordComponent,
  ],
  templateUrl: './update-data.component.html',
  styleUrl: './update-data.component.css',
})
export class UpdateDataComponent {
  private formBuilder = inject(UntypedFormBuilder);
  private alertsService = inject(AlertsService);
  public usuario: UsuarioResponseDto = new UsuarioResponseDto();
  private userService = inject(UserService);
  private autenticacionStoreService = inject(AutenticacionStoreService);
  private destroyRef = inject(DestroyRef);
  private countryService = inject(CountryService);
  public countryDTO: Array<CountryDto> = new Array<CountryDto>();

  public usuarioId: number = 0;
  public primerNombreError: string = '';
  public segundoNombreError: string = '';
  public primerApellidoError: string = '';
  public segundoApellidoError: string = '';
  public nombreUsuarioError: string = '';
  public correoError: string = '';
  public celularError: string = '';
  public ciudadError: string = '';
  public fechaNacimientoError: string = '';
  public actualizarActivo: boolean = true;
  public cambiarActivo: boolean = false;
  public nombrePestana: string = 'Actualizar datos';

  public formularioActualizar: UntypedFormGroup = new UntypedFormGroup({});
  public modoEdicion: boolean = false;
  public selected: number = 1;

  constructor() {
    this.buildForm();
  }

  ngOnInit(): void {
    this.cargarDatosUsuario();
    this.mostrarIndicativos();
  }

  buildForm(): void {
    this.formularioActualizar = this.formBuilder.group({
      primer_nombre: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_4),
          Validators.maxLength(Constant.CAMPO_MAXIMO_50),
        ],
      ],
      segundo_nombre: [
        '',
        [
          Validators.minLength(Constant.CAMPO_MINIMO_4),
          Validators.maxLength(Constant.CAMPO_MAXIMO_50),
        ],
      ],
      primer_apellido: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_4),
          Validators.maxLength(Constant.CAMPO_MAXIMO_50),
        ],
      ],
      segundo_apellido: [
        '',
        [
          Validators.minLength(Constant.CAMPO_MINIMO_4),
          Validators.maxLength(Constant.CAMPO_MAXIMO_50),
        ],
      ],
      nombre_usuario: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_4),
          Validators.maxLength(Constant.CAMPO_MAXIMO_50),
          Validators.pattern(Constant.PATTERN_LETRAS_NUMEROS),
        ],
      ],
      correo: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_4),
          Validators.maxLength(Constant.CAMPO_MAXIMO_100),
          Validators.pattern(Constant.PATTERN_CORREO),
        ],
      ],
      indicador: [
        '',
        [
          //     Validators.required
        ],
      ],
      celular: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_2),
          Validators.maxLength(Constant.CAMPO_MAXIMO_20),
          Validators.pattern(Constant.PATTERN_NUMEROS),
        ],
      ],
      fecha_nacimiento: ['', [Validators.required]],
    });
  }

  get primer_nombre(): AbstractControl {
    return this.formularioActualizar.get('primer_nombre')!;
  }

  get segundo_nombre(): AbstractControl {
    return this.formularioActualizar.get('segundo_nombre')!;
  }

  get primer_apellido(): AbstractControl {
    return this.formularioActualizar.get('primer_apellido')!;
  }

  get segundo_apellido(): AbstractControl {
    return this.formularioActualizar.get('segundo_apellido')!;
  }

  get nombre_usuario(): AbstractControl {
    return this.formularioActualizar.get('nombre_usuario')!;
  }

  get correo(): AbstractControl {
    return this.formularioActualizar.get('correo')!;
  }

  get indicativo(): AbstractControl {
    return this.formularioActualizar.get('indicativo')!;
  }

  get celular(): AbstractControl {
    return this.formularioActualizar.get('celular')!;
  }

  get fecha_nacimiento(): AbstractControl {
    return this.formularioActualizar.get('fecha_nacimiento')!;
  }

  validarPrimerNombre(): boolean {
    let status = false;
    if (this.primer_nombre.touched) {
      if (this.primer_nombre.hasError('required')) {
        this.primerNombreError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      } else if (this.primer_nombre.hasError('minlength')) {
        this.primerNombreError = Constant.ERROR_CAMPO_MINIMO_4;
        status = true;
      } else if (this.primer_nombre.hasError('maxlength')) {
        this.primerNombreError = Constant.ERROR_CAMPO_MAXIMO_50;
        status = true;
      }
    }
    return status;
  }

  validarSegundoNombre(): boolean {
    let status = false;
    if (this.segundo_nombre.touched) {
      if (this.segundo_nombre.hasError('minlength')) {
        this.segundoNombreError = Constant.ERROR_CAMPO_MINIMO_4;
        status = true;
      } else if (this.segundo_nombre.hasError('maxlength')) {
        this.segundoNombreError = Constant.ERROR_CAMPO_MAXIMO_50;
        status = true;
      }
    }
    return status;
  }

  validarPrimerApellido(): boolean {
    let status = false;
    if (this.primer_apellido.touched) {
      if (this.primer_apellido.hasError('required')) {
        this.primerApellidoError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      } else if (this.primer_apellido.hasError('minlength')) {
        this.primerApellidoError = Constant.ERROR_CAMPO_MINIMO_4;
        status = true;
      } else if (this.primer_apellido.hasError('maxlength')) {
        this.primerApellidoError = Constant.ERROR_CAMPO_MAXIMO_50;
        status = true;
      }
    }
    return status;
  }

  validarSegundoApellido(): boolean {
    let status = false;
    if (this.segundo_apellido.touched) {
      if (this.segundo_apellido.hasError('minlength')) {
        this.segundoApellidoError = Constant.ERROR_CAMPO_MINIMO_4;
        status = true;
      } else if (this.segundo_apellido.hasError('maxlength')) {
        this.segundoApellidoError = Constant.ERROR_CAMPO_MAXIMO_50;
        status = true;
      }
    }
    return status;
  }

  validarNombreUsuario(): boolean {
    let status = false;
    if (this.nombre_usuario.touched) {
      if (this.nombre_usuario.hasError('required')) {
        this.nombreUsuarioError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      } else if (this.nombre_usuario.hasError('minlength')) {
        this.nombreUsuarioError = Constant.ERROR_CAMPO_MINIMO_4;
        status = true;
      } else if (this.nombre_usuario.hasError('maxlength')) {
        this.nombreUsuarioError = Constant.ERROR_CAMPO_MAXIMO_50;
        status = true;
      } else if (this.nombre_usuario.hasError('pattern')) {
        this.nombreUsuarioError = Constant.ERROR_CAMPO_SOLO_NUMEROS_LETRAS;
        status = true;
      }
    }
    return status;
  }

  validarCorreo(): boolean {
    let status = false;
    if (this.correo.touched) {
      if (this.correo.hasError('required')) {
        this.correoError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      } else if (this.correo.hasError('minlength')) {
        this.correoError = Constant.ERROR_CAMPO_MINIMO_4;
        status = true;
      } else if (this.correo.hasError('maxlength')) {
        this.correoError = Constant.ERROR_CAMPO_MAXIMO_50;
        status = true;
      } else if (this.correo.hasError('pattern')) {
        this.correoError = Constant.ERROR_CAMPO_EMAIL_INVALIDO;
        status = true;
      }
    }
    return status;
  }

  validarCelular(): boolean {
    let status = false;
    if (this.celular.touched) {
      if (this.celular.hasError('required')) {
        this.celularError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      } else if (this.celular.hasError('minlength')) {
        this.celularError = Constant.ERROR_CAMPO_MINIMO_2;
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

  validarFechaNacimiento(): boolean {
    let status = false;
    if (this.fecha_nacimiento.touched) {
      if (this.fecha_nacimiento.hasError('required')) {
        this.fechaNacimientoError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  mostrarIndicativos(): void {
    this.countryService
      .getAll()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe(
        (res: any) => {
          this.countryDTO = res.payload as CountryDto[];
        },
        (err) => {
          this.alertsService.fireError(err);
        }
      );
  }

  activarPestana(pestana: string): void {
    if (pestana === 'actualizar') {
      this.actualizarActivo = true;
      this.cambiarActivo = false;
      this.nombrePestana = 'Actualizar datos';
      this.cargarDatosUsuario();
    } else if (pestana === 'cambiar') {
      this.actualizarActivo = false;
      this.cambiarActivo = true;
      this.nombrePestana = 'Cambiar contraseña';
    }
  }

  cargarDatosUsuario(): void {
    this.autenticacionStoreService
      .obtenerSesion$()
      .pipe(
        map((usuario: UsuarioResponseDto) => usuario?.id ?? 0),
        filter((id: number) => id !== 0),
        switchMap((id: number) => this.userService.getById(id))
      )
      .subscribe({
        next: (response) => {
          console.log(response);
          if (response?.payload) {
            this.usuario = response.payload;
            this.usuarioId = this.usuario.id ?? 0;
            this.llenarFormulario();
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

  llenarFormulario(): void {
    if (this.usuario?.date_of_birth) {
      const [year, month, day] = this.usuario.date_of_birth
        .split('-')
        .map(Number);
      const fechaNacimiento = new Date(year, month - 1, day);

      this.formularioActualizar.patchValue({
        primer_nombre: this.usuario.name,
        segundo_nombre: this.usuario.second_name,
        primer_apellido: this.usuario.last_name,
        segundo_apellido: this.usuario.second_last_name,
        nombre_usuario: this.usuario.username,
        correo: this.usuario.email,
        celular: this.usuario.mobile_number,
        fecha_nacimiento: fechaNacimiento,
      });
    } else {
      this.formularioActualizar.patchValue({
        fecha_nacimiento: null,
      });
    }
  }

  formatearFecha(fecha: string): string {
    if (!fecha) {
      return '';
    }
    const fechaObj = new Date(fecha);
    return fechaObj.toLocaleDateString('en-US');
  }

  actualizarDatos(): void {
    if (this.formularioActualizar.valid) {
      const selectedCountry = this.countryDTO.find(
        (country) => country.id === this.selected
      );

      const cellPrefix = selectedCountry ? selectedCountry.cellPrefix : '';

      this.usuario = {
        id: this.usuarioId,
        name: this.primer_nombre.value,
        second_name: this.segundo_nombre.value,
        last_name: this.primer_apellido.value,
        second_last_name: this.segundo_apellido.value,
        mobile_number: `${cellPrefix}${this.celular.value}`,
        email: this.correo.value,
        username: this.nombre_usuario.value,
        date_of_birth: this.fecha_nacimiento.value
          ? new Date(this.fecha_nacimiento.value).toISOString().split('T')[0]
          : undefined,
      };

      this.userService
        .update(this.usuario)
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe(
          () => {
            this.cargarDatosUsuario();
            this.alertsService.toast(
              'success',
              'Usuario actualizado exitosamente.'
            );
          },
          (err) => {
            console.log(err);
            const errorDto = new MessageExceptionDto({
              status: err.error?.status,
              error: err.error?.error,
              recommendation: err.error?.recommendation,
            });
            console.log(errorDto);
            this.alertsService.fireError(errorDto);
          }
        );
    } else {
      this.formularioActualizar.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }
}

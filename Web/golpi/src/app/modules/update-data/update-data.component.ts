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
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatCardModule } from '@angular/material/card';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatSelectModule } from '@angular/material/select';
import { Constant } from '../../shared/utils/constant';
import { AlertsService } from '../../core/service/alerts.service';
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { ChangePasswordComponent } from '../change-password/change-password.component';
import { UsuarioResponseDto } from '../../data/schema/userResponseDto';
import { UserService } from '../../core/service/user.service';
import { AutenticacionStoreService } from '../../core/store/auth/autenticacion-store.service';
import { filter, map, switchMap } from 'rxjs/operators';
import { NgSelectModule } from '@ng-select/ng-select';

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
    MatCardModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatSelectModule,
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
  public selected: string = 'COP';

  public indicativos = [
    { value: 'COP', label: '+57' },
    { value: 'EEUU', label: '+1' },
    { value: 'MEX', label: '+52' },
  ];

  constructor() {
    this.buildForm();
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
      indicador: [this.selected, [Validators.required]],
      celular: [
        '',
        [
          Validators.required,
          Validators.minLength(Constant.CAMPO_MINIMO_2),
          Validators.maxLength(Constant.CAMPO_MAXIMO_20),
          Validators.pattern(Constant.PATTERN_NUMEROS),
        ],
      ],
      ciudad: ['', [Validators.required]],
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

  get celular(): AbstractControl {
    return this.formularioActualizar.get('celular')!;
  }

  get ciudad(): AbstractControl {
    return this.formularioActualizar.get('ciudad')!;
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

  validarCiudad(): boolean {
    let status = false;
    if (this.ciudad.touched) {
      if (this.ciudad.hasError('required')) {
        this.ciudadError = Constant.ERROR_CAMPO_REQUERIDO;
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

  limpiarFormulario(): void {
    this.formularioActualizar.reset();
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
      this.limpiarFormulario();
    }
  }

  ngOnInit(): void {
    this.cargarDatosUsuario();
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
          if (response?.payload) {
            this.usuario = response.payload;
            this.llenarFormulario();
          }
        },
        error: () => {
          console.error('Error al cargar los datos del usuario');
        },
      });
  }

  llenarFormulario(): void {
    const fechaNacimiento = this.usuario.dateOfBirth
      ? new Date(this.usuario.dateOfBirth)
      : null;

    this.formularioActualizar.patchValue({
      primer_nombre: this.usuario.name,
      segundo_nombre: this.usuario.secondName,
      primer_apellido: this.usuario.lastName,
      segundo_apellido: this.usuario.secondLastName,
      nombre_usuario: this.usuario.username,
      correo: this.usuario.email,
      celular: this.usuario.mobileNumber,
      fecha_nacimiento: fechaNacimiento,
    });
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
      console.log('Se actualizo los datos');
    } else {
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }
}

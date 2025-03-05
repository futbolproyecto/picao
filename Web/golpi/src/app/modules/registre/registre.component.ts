// Core
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
import { trigger, transition, style, animate } from '@angular/animations';

// Librerias
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { NgSelectModule } from '@ng-select/ng-select';

// Servicios
import { ModoAuthService } from '../../core/service/modo-auth.service';

// Compartidos
import { Constant } from '../../shared/utils/constant';

@Component({
  selector: 'app-registre',
  standalone: true,
  imports: [
    CommonModule,
    MatInputModule,
    MatIconModule,
    MatButtonModule,
    FormsModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    NgSelectModule,
  ],
  templateUrl: './registre.component.html',
  styleUrls: ['./registre.component.css'],
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
export class RegistreComponent {
  private formBuilder = inject(UntypedFormBuilder);
  private ModoAuthService = inject(ModoAuthService);

  public esModoRegistro: boolean = false;
  public formularioRegistro: UntypedFormGroup = new UntypedFormGroup({});

  //cadenas para errores
  public nombreError: string = '';
  public indicadorError: string = '';
  public celularError: string = '';
  public correoError: string = '';

  public selected: string = 'COP';

  public indicativos = [
    { value: 'COP', label: '+57' },
    { value: 'EEUU', label: '+1' },
    { value: 'MEX', label: '+52' },
  ];

  constructor() {
    this.buildForm();
    this.ModoAuthService.esModoRegistro$.subscribe((modo) => {
      this.esModoRegistro = modo;
    });
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
      indicador: [this.selected, [Validators.required]],
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

  get indicador(): AbstractControl {
    return this.formularioRegistro.get('indicador')!;
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

  validarIndicador(): boolean {
    let status = false;
    if (this.indicador.touched) {
      if (this.indicador.hasError('required')) {
        this.indicadorError = Constant.ERROR_CAMPO_REQUERIDO;
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

  cambioModoInicioRegistro() {
    this.ModoAuthService.setModoRegistro(false);
    this.limpiarFormulario();
  }

  limpiarFormulario(): void {
    this.formularioRegistro.reset();
    this.formularioRegistro.patchValue({ indicador: this.selected });
  }

  enviar(): void {
    if (this.formularioRegistro.invalid) {
      this.formularioRegistro.markAllAsTouched();
      return;
    }

    console.log('Enviando datos...');
  }
}

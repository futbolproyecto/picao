import { CommonModule } from '@angular/common';
import { Component, DestroyRef, inject } from '@angular/core';
import {
  AbstractControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { MatInputModule } from '@angular/material/input';
import { Constant } from '../../shared/utils/constant';
import { MatSelectModule } from '@angular/material/select';
import { DataTableComponent } from '../../shared/components/custom/data-table/data-table.component';
import { AlertsService } from '../../core/service/alerts.service';
import { NgSelectModule } from '@ng-select/ng-select';
import { DepartmentService } from '../../core/service/departament.service';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { DepartamentResponseDto } from '../../data/schema/departamentResponseDTO';
import { CityService } from '../../core/service/city.service';
import { CityDto } from '../../data/schema/cityDto';

@Component({
  selector: 'app-establishment',
  standalone: true,
  imports: [
    CommonModule,
    MatInputModule,
    ReactiveFormsModule,
    MatSelectModule,
    FormsModule,
    DataTableComponent,
    NgSelectModule,
  ],
  templateUrl: './establishment.component.html',
  styleUrl: './establishment.component.css',
})
export class EstablishmentComponent {
  private formBuilder = inject(UntypedFormBuilder);
  private alertsService = inject(AlertsService);
  private departamentService = inject(DepartmentService);
  private cityService = inject(CityService);
  private destroyRef = inject(DestroyRef);

  public formularioEstablecimiento: UntypedFormGroup = new UntypedFormGroup({});
  public departamentoDTO: Array<DepartamentResponseDto> =
    new Array<DepartamentResponseDto>();
  public cityDTO: Array<CityDto> = new Array<CityDto>();

  public nombreError: string = '';
  public cantidadCanchasError: string = '';
  public direccionError: string = '';
  public telefonoError: string = '';
  public departamentoError: string = '';
  public ciudadError: string = '';
  public selectedCities: number = 1;
  public selectedDepartment: number = 1;

  public estado: boolean = true;
  public edit: boolean = true;

  public encabezadosEstablecimientos = {
    id: 'ID',
    nombre_establecimiento: 'Nombre establecimiento',
    cantidad_canchas: 'Cant. canchas',
    direccion: 'Dirección',
    telefono: 'Teléfono',
    acciones: 'Acciones',
  };

  tablaEstablecimientos = [
    {
      id: '1',
      nombre_establecimiento: 'ManualidadesMBD',
      cantidad_canchas: '5',
      direccion: 'Cra 46a # 12 - 30',
      telefono: 3148688564,
    },
    {
      id: '2',
      nombre_establecimiento: 'Maracana',
      cantidad_canchas: '7',
      direccion: 'Cra 83c # 17 - 52',
      telefono: 3215877695,
    },
  ];

  constructor() {
    this.mostrarDepartamento();
    this.mostrarCiudades();
    this.buildForm();
  }

  mostrarDepartamento(): void {
    this.departamentService
      .getAll()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe(
        (res: any) => {
          this.departamentoDTO = res.payload as DepartamentResponseDto[];
          console.log(this.departamentoDTO);
        },
        (err) => {
          this.alertsService.fireError(err);
        }
      );
  }

  mostrarCiudades(): void {
    this.cityService
      .getAll()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe(
        (res: any) => {
          this.cityDTO = res.payload as CityDto[];
          console.log(res);
          console.log(this.cityDTO);
        },
        (err) => {
          this.alertsService.fireError(err);
        }
      );
  }

  buildForm(): void {
    this.formularioEstablecimiento = this.formBuilder.group({
      nombre_establecimiento: ['', [Validators.required]],
      cantidad_canchas: ['', [Validators.required]],
      direccion: ['', [Validators.required]],
      telefono: ['', [Validators.required]],
      departamento: [null, [Validators.required]],
      ciudad: [null, [Validators.required]],
    });
  }

  get nombre_establecimiento(): AbstractControl {
    return this.formularioEstablecimiento.get('nombre_establecimiento')!;
  }

  get cantidad_canchas(): AbstractControl {
    return this.formularioEstablecimiento.get('cantidad_canchas')!;
  }

  get direccion(): AbstractControl {
    return this.formularioEstablecimiento.get('direccion')!;
  }

  get telefono(): AbstractControl {
    return this.formularioEstablecimiento.get('telefono')!;
  }

  get departamento(): AbstractControl {
    return this.formularioEstablecimiento.get('departamento')!;
  }

  get ciudad(): AbstractControl {
    return this.formularioEstablecimiento.get('ciudad')!;
  }

  validarNombre(): boolean {
    let status = false;
    if (this.nombre_establecimiento.touched) {
      if (this.nombre_establecimiento.hasError('required')) {
        this.nombreError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarCantidadCancha(): boolean {
    let status = false;
    if (this.cantidad_canchas.touched) {
      if (this.cantidad_canchas.hasError('required')) {
        this.cantidadCanchasError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarDireccion(): boolean {
    let status = false;
    if (this.direccion.touched) {
      if (this.direccion.hasError('required')) {
        this.direccionError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarTelefono(): boolean {
    let status = false;
    if (this.telefono.touched) {
      if (this.telefono.hasError('required')) {
        this.telefonoError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarDepartamento(): boolean {
    let status = false;
    if (this.departamento.touched) {
      if (this.departamento.hasError('required')) {
        this.departamentoError = Constant.ERROR_CAMPO_REQUERIDO;
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

  limpiarFormulario(): void {
    this.formularioEstablecimiento.reset();
  }

  registrarEstablecimiento(): void {
    if (this.formularioEstablecimiento.valid) {
      console.log('Se guardo los datos');
      this.limpiarFormulario();
    } else {
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }
}

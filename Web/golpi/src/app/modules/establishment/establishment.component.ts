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
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { finalize } from 'rxjs';

// Librerias
import { MatInputModule } from '@angular/material/input';
import { NgSelectModule } from '@ng-select/ng-select';

// Servicios
import { AlertsService } from '../../core/service/alerts.service';
import { CityService } from '../../core/service/city.service';
import { EstablishmentService } from '../../core/service/establishment.service';
import { AutenticacionStoreService } from '../../core/store/auth/autenticacion-store.service';

// Compartidos
import { Constant } from '../../shared/utils/constant';
import { DataTableComponent } from '../../shared/components/custom/data-table/data-table.component';

// Dto
import { CityDto } from '../../data/schema/cityDto';
import { EstablishmentRequestDto } from '../../data/schema/establishmentRequestDto';
import { MessageExceptionDto } from '../../data/schema/MessageExceptionDto';
import { BusyService } from '../../core/busy.service';

@Component({
  selector: 'app-establishment',
  standalone: true,
  imports: [
    CommonModule,
    MatInputModule,
    ReactiveFormsModule,
    FormsModule,
    DataTableComponent,
    NgSelectModule,
  ],
  templateUrl: './establishment.component.html',
  styleUrl: './establishment.component.css',
})
export class EstablishmentComponent implements OnInit {
  private formBuilder = inject(UntypedFormBuilder);
  private alertsService = inject(AlertsService);
  private cityService = inject(CityService);
  private establishmentService = inject(EstablishmentService);
  private destroyRef = inject(DestroyRef);

  public establecimientoDto: EstablishmentRequestDto =
    new EstablishmentRequestDto();
  public formularioEstablecimiento: UntypedFormGroup = new UntypedFormGroup({});
  public cityDTO: Array<CityDto> = new Array<CityDto>();

  public nombreError: string = '';
  public direccionError: string = '';
  public telefonoError: string = '';
  public ciudadError: string = '';
  public selectedCities: number = 1;
  public selectedDepartment: number = 1;

  public tablaEstablecimientos: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();
  public establecimientoTitulo: string = 'establecimientos';

  public encabezadosEstablecimientos = {
    name: 'Nombre establecimiento',
    address: 'Dirección',
    mobileNumber: 'Teléfono',
    cityName: 'Ciudad',
  };

  constructor(private busyService: BusyService) {
    this.buildForm();
  }

  ngOnInit() {
    this.cargarEstablecimientosUsuario();
    this.mostrarCiudades();
  }

  mostrarCiudades(): void {
    this.cityService
      .getAll()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe({
        next: (res: any) => {
          this.cityDTO = res.payload as CityDto[];
        },
        error: (err) => {
          this.alertsService.fireError(err);
        },
      });
  }

  cargarEstablecimientosUsuario(): void {
    const authDataString = sessionStorage.getItem('authentication');
    if (authDataString) {
      const authData = JSON.parse(authDataString);
      const usuarioId = authData.id;

      if (usuarioId !== 0) {
        this.establishmentService
          .establecimientoPorUsuario(usuarioId)
          .subscribe({
            next: (response) => {
              console.log('response', response);

              this.tablaEstablecimientos = (
                response.payload as EstablishmentRequestDto[]
              ).map((e) => ({
                ...e,
                cityName: e.city?.name,
              }));
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
    }
  }

  buildForm(): void {
    this.formularioEstablecimiento = this.formBuilder.group({
      nombre_establecimiento: ['', [Validators.required]],
      direccion: ['', [Validators.required]],
      telefono: ['', [Validators.required]],
      ciudad: [null, [Validators.required]],
    });
  }

  get nombre_establecimiento(): AbstractControl {
    return this.formularioEstablecimiento.get('nombre_establecimiento')!;
  }

  get direccion(): AbstractControl {
    return this.formularioEstablecimiento.get('direccion')!;
  }

  get telefono(): AbstractControl {
    return this.formularioEstablecimiento.get('telefono')!;
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
      this.establecimientoDto = {
        name: this.nombre_establecimiento.value,
        address: this.direccion.value,
        mobile_number: this.telefono.value,
        city_id: this.ciudad.value,
      };

      this.busyService.busy();

      this.establishmentService
        .crearEstablecimiento(this.establecimientoDto)
        .pipe(
          takeUntilDestroyed(this.destroyRef),
          finalize(() => {
            this.busyService.idle();
          })
        )
        .subscribe({
          next: () => {
            this.alertsService.toast(
              'success',
              'Establecimiento registrado exitosamente.'
            );
            this.limpiarFormulario();
            this.cargarEstablecimientosUsuario();
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
      this.formularioEstablecimiento.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }
}

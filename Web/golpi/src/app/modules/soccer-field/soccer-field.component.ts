// Core
import { Component, inject, DestroyRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  AbstractControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';

// Servicios
import { AlertsService } from '../../core/service/alerts.service';

// Librerias
import { MatInputModule } from '@angular/material/input';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { NgSelectModule } from '@ng-select/ng-select';
import { MatIconModule } from '@angular/material/icon';

// Compartidos
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { DataTableComponent } from '../../shared/components/custom/data-table/data-table.component';
import { Constant } from '../../shared/utils/constant';

// Componentes
import { EstablishmentComponent } from '../establishment/establishment.component';
import { FieldService } from '../../core/service/field.service';
import { FieldRequestDto } from '../../data/schema/fieldRequestDTO';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { MessageExceptionDto } from '../../data/schema/MessageExceptionDto';
import { filter, map, switchMap } from 'rxjs';
import { AutenticacionStoreService } from '../../core/store/auth/autenticacion-store.service';
import { UsuarioResponseDto } from '../../data/schema/userResponseDto';
import { EstablishmentService } from '../../core/service/establishment.service';

@Component({
  selector: 'app-soccer-field',
  standalone: true,
  imports: [
    CardComponent,
    MatIconModule,
    CommonModule,
    EstablishmentComponent,
    DataTableComponent,
    MatInputModule,
    ReactiveFormsModule,
    FormsModule,
    NgSelectModule,
    MatCheckboxModule,
  ],
  templateUrl: './soccer-field.component.html',
  styleUrl: './soccer-field.component.css',
})
export class SoccerFieldComponent {
  private readonly autenticacionStore = inject(AutenticacionStoreService);
  private formBuilder = inject(UntypedFormBuilder);
  public formularioCancha: UntypedFormGroup = new UntypedFormGroup({});
  private alertsService = inject(AlertsService);
  private fieldService = inject(FieldService);
  private destroyRef = inject(DestroyRef);
  private establishmentService = inject(EstablishmentService);
  public tablaCanchas: Array<FieldRequestDto> = new Array<FieldRequestDto>();

  public fieldDto: FieldRequestDto = new FieldRequestDto();
  public registrarCanchaActivo: boolean = false;
  public registrarEstablecimientoActivo: boolean = true;
  public nombrePestana: string = 'Registrar establecimiento';

  public listaEstablecimientos: any[] = [];
  public establecimientoSeleccionado: any = null;
  public descripcionCanchaError: string = '';
  public cantidadJugadoresError: string = '';
  public tipoCanchaError: string = '';
  public establecimientoError: string = '';

  public estado: boolean = true;
  public edit: boolean = true;

  public encabezadosCanchas = {
    name: 'Descripción cancha',
    capacity: 'Cant. jugadores',
    is_available: 'Disponible',
    is_roofed: 'Techado',
    acciones: 'Acciones',
  };

  constructor() {
    this.buildForm();
    this.cargarEstablecimientosUsuario();
    this.cargarCanchaEstablecimiento();
  }

  cargarCanchaEstablecimiento(): void {
    const idEstablecimiento = localStorage.getItem(
      'establecimientoSeleccionado'
    );

    if (!idEstablecimiento) {
      this.alertsService.toast(
        'error',
        'No se ha seleccionado un establecimiento.'
      );
      return;
    }

    this.fieldService.canchaPorEstablecimiento(idEstablecimiento).subscribe({
      next: (response) => {
        if (response?.payload) {
          this.tablaCanchas = response.payload;
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

  cargarEstablecimientosUsuario(): void {
    this.autenticacionStore
      .obtenerSesion$()
      .pipe(
        map((usuario: UsuarioResponseDto) => {
          const id = usuario?.id ? Number(usuario.id) : 0;
          return id;
        }),
        filter((id: number) => id > 0),
        switchMap((id: number) =>
          this.establishmentService.establecimientoPorUsuario(id)
        )
      )
      .subscribe({
        next: (response) => {
          if (response?.payload) {
            this.listaEstablecimientos = response.payload.map((est: any) => ({
              id: est.id,
              name: est.name,
            }));
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

  buildForm(): void {
    this.formularioCancha = this.formBuilder.group({
      descripcion_cancha: ['', [Validators.required]],
      cantidad_jugadores: ['', [Validators.required]],
      disponible: [false],
      techado: [false],
    });
  }

  get descripcion_cancha(): AbstractControl {
    return this.formularioCancha.get('descripcion_cancha')!;
  }

  get cantidad_jugadores(): AbstractControl {
    return this.formularioCancha.get('cantidad_jugadores')!;
  }

  get disponible(): AbstractControl {
    return this.formularioCancha.get('disponible')!;
  }

  get techado(): AbstractControl {
    return this.formularioCancha.get('techado')!;
  }

  validarDescripcionCancha(): boolean {
    let status = false;
    if (this.descripcion_cancha.touched) {
      if (this.descripcion_cancha.hasError('required')) {
        this.descripcionCanchaError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  validarCantidadJugadores(): boolean {
    let status = false;
    if (this.cantidad_jugadores.touched) {
      if (this.cantidad_jugadores.hasError('required')) {
        this.cantidadJugadoresError = Constant.ERROR_CAMPO_REQUERIDO;
        status = true;
      }
    }
    return status;
  }

  activarPestana(pestana: string): void {
    if (pestana === 'registrarEstablecimiento') {
      this.registrarEstablecimientoActivo = true;
      this.registrarCanchaActivo = false;
      this.nombrePestana = 'Registrar establecimiento';
    } else if (pestana === 'registrarCancha') {
      this.registrarEstablecimientoActivo = false;
      this.registrarCanchaActivo = true;
      this.nombrePestana = 'Registrar canchas';
    }
  }

  registrarCancha(): void {
    if (this.formularioCancha.valid) {
      const idEstablecimiento =
        localStorage.getItem('establecimientoSeleccionado') ?? undefined;

      this.fieldDto = {
        name: this.descripcion_cancha.value,
        capacity: this.cantidad_jugadores.value,
        is_available: this.disponible.value,
        is_roofed: this.techado.value,
        establishment_id: idEstablecimiento,
      };

      this.fieldService
        .crearCancha(this.fieldDto)
        .pipe(takeUntilDestroyed(this.destroyRef))
        .subscribe(
          () => {
            this.alertsService.toast(
              'success',
              'Cancha registrada exitosamente.'
            );
            this.limpiarFormulario();
            this.cargarCanchaEstablecimiento();
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
      this.formularioCancha.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  limpiarFormulario(): void {
    this.formularioCancha.reset();
  }
}

// Core
import { Component, DestroyRef, Inject, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  AbstractControl,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { finalize } from 'rxjs';

// Librerias
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { NgSelectModule } from '@ng-select/ng-select';
import { MatNativeDateModule } from '@angular/material/core';
import { MatCard, MatCardContent, MatCardTitle } from '@angular/material/card';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatCheckbox } from '@angular/material/checkbox';

// Compatidos
import { Constant } from '../../../shared/utils/constant';

// Servicios
import { AlertsService } from '../../../core/service/alerts.service';
import { EstablishmentService } from '../../../core/service/establishment.service';
import { BusyService } from '../../../core/busy.service';
import { AgendaService } from '../../../core/service/agenda.service';

// Dto
import { EstablishmentRequestDto } from '../../../data/schema/establishmentRequestDto';
import { MessageExceptionDto } from '../../../data/schema/MessageExceptionDto';
import { AgendaDto } from '../../../data/schema/agendaDto';
import { InformacionReservaDto } from '../../../data/schema/informacionReservaDto';
import { ReserveRequestDto } from '../../../data/schema/reserveRequestDto';
import { OtpService } from '../../../core/service/otp.service';
import { OtpRequestDto } from '../../../data/schema/otpRequestDto';
import { UserResponseDto } from '../../../data/schema/userResponseDto';
import { UserService } from '../../../core/service/user.service';

@Component({
  selector: 'app-modal-reservation',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
    NgSelectModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatCard,
    MatCardTitle,
    MatCardContent,
    MatCheckbox,
  ],
  templateUrl: './modal-reservation.component.html',
  styleUrl: './modal-reservation.component.css',
})
export class ModalReservationComponent implements OnInit {
  private establishmentService = inject(EstablishmentService);
  private destroyRef = inject(DestroyRef);
  private busyService = inject(BusyService);
  private agendaService = inject(AgendaService);
  private alertsService = inject(AlertsService);
  private otpService = inject(OtpService);
  private userService = inject(UserService);

  public formularioReserva: UntypedFormGroup = new UntypedFormGroup({});
  private formBuilder = inject(UntypedFormBuilder);

  public agendaDto: AgendaDto = new AgendaDto();
  public establishmentDto: Array<EstablishmentRequestDto> =
    new Array<EstablishmentRequestDto>();
  public informacionReserva: InformacionReservaDto[] = [];
  public horariosSeleccionados: InformacionReservaDto[] = [];
  public usuario: UserResponseDto = new UserResponseDto();
  public reserveRequestDto: ReserveRequestDto = new ReserveRequestDto();
  public otpRequestDto: OtpRequestDto = new OtpRequestDto();

  public establishmentError: string = '';
  public ciudadEstablecimiento: string = '';
  public horasDisponibles: string[] = [];
  public numeroCelularUsuario: string = '';

  constructor(
    private dialogRef: MatDialogRef<ModalReservationComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      startDate: string;
      endDate: string;
      startTime: string;
      endTime: string;
    }
  ) {
    this.buildForm();
  }

  ngOnInit() {
    this.cargarEstablecimientosUsuario();
    this.generarHoras();

    const [day, month, year] = this.data.startDate.split('-');
    const fecha = new Date(+year, +month - 1, +day);

    this.formularioReserva.get('fecha')?.setValue(fecha);
    this.formularioReserva.get('hora_inicio')?.setValue(this.data.startTime);
    this.formularioReserva.get('hora_fin')?.setValue(this.data.endTime);
    this.formularioReserva.get('establishment')?.setValue('Seleccione...');

    const authDataString = sessionStorage.getItem('authentication');
    if (authDataString) {
      const authData = JSON.parse(authDataString);
      this.usuario.id = authData.id;

      this.userService.getById(authData.id).subscribe({
        next: (response) => {
          if (response?.payload) {
            this.usuario = response.payload;
            this.numeroCelularUsuario = this.usuario.mobile_number!;
          }
        },
        error: () => {},
      });
    }
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
              const establecimientos =
                response?.payload as EstablishmentRequestDto[];

              const opcionDefault = { name: 'Seleccione...' };

              this.establishmentDto = [opcionDefault, ...establecimientos];

              if (establecimientos.length > 0 && establecimientos[0].city) {
                this.ciudadEstablecimiento =
                  establecimientos[0].city.name || '';
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
    }
  }

  generarHoras(): void {
    const horas = [];
    for (let i = 0; i < 24; i++) {
      const hora = i.toString().padStart(2, '0');
      const horaFormateada = `${hora}:00:00`;
      horas.push(horaFormateada);
    }
    this.horasDisponibles = horas;
  }

  buildForm(): void {
    this.formularioReserva = this.formBuilder.group({
      establishment: [Validators.required],
      fecha: [Validators.required],
      hora_inicio: [Validators.required],
      hora_fin: [Validators.required],
    });
  }

  get establishment(): AbstractControl {
    return this.formularioReserva.get('establishment')!;
  }

  get fecha(): AbstractControl {
    return this.formularioReserva.get('fecha')!;
  }

  get hora_inicio(): AbstractControl {
    return this.formularioReserva.get('hora_inicio')!;
  }

  get hora_fin(): AbstractControl {
    return this.formularioReserva.get('hora_fin')!;
  }

  validarEstablecimiento(): boolean {
    let status = false;
    if (this.establishment.touched) {
      if (this.establishment.hasError('required')) {
        this.establishmentError = Constant.ERROR_CAMPO_ESTABLECIMIENTO;
        status = true;
      }
    }
    return status;
  }

  private formatDateToISO(date: Date): string {
    if (!date) return '';
    return date.toISOString().split('T')[0];
  }

  buscarDisponibilidad() {
    if (this.formularioReserva.valid) {
      if (this.establishment.value == 'Seleccione...') {
        this.alertsService.toast(
          'error',
          'Debes seleccionar un establecimiento'
        );
        return;
      }

      this.agendaDto = {
        establishmentName: this.establishment.value,
        fecha: this.formatDateToISO(this.fecha.value),
        startTime: this.hora_inicio.value,
        endTime: this.hora_fin.value,
        cityName: this.ciudadEstablecimiento,
      };

      this.busyService.busy();
      this.agendaService
        .buscarDisponibilidad(this.agendaDto)
        .pipe(
          takeUntilDestroyed(this.destroyRef),
          finalize(() => {
            this.busyService.idle();
          })
        )
        .subscribe({
          next: (res) => {
            const payload = res?.payload;
            if (Array.isArray(payload) && payload.length > 0) {
              this.informacionReserva = payload.map((elemento: any) => {
                return new InformacionReservaDto({
                  id: elemento.id,
                  nombreEstablecimiento: elemento.name_establishment,
                  direccion: elemento.address_establishment,
                  tipoCancha: elemento.name_field,
                  horarioDisponible: elemento.start_time,
                  precioPorHora: elemento.fee,
                });
              });
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
    } else {
      this.formularioReserva.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }

  cerrar() {
    this.alertsService.fireConfirm(
      'warning',
      '',
      '¿Deseas cerrar este formulario sin guardar los cambios?',
      () => {
        this.dialogRef.close();
      }
    );
  }

  horarioSeleccionado(horario: InformacionReservaDto) {
    const index = this.horariosSeleccionados.findIndex(
      (h) => h.id === horario.id
    );

    if (index > -1) {
      this.horariosSeleccionados.splice(index, 1);
    } else {
      this.horariosSeleccionados.push(horario);
    }
  }

  esHorarioSeleccionado(id: string): boolean {
    return this.horariosSeleccionados.some((h) => h.id === id);
  }

  envioOtp() {
    this.otpRequestDto = {
      mobile_number: this.numeroCelularUsuario,
      is_reserve: true,
    };

    this.otpService
      .envioCodigoNumeroCelular(this.otpRequestDto)
      .pipe(
        takeUntilDestroyed(this.destroyRef),
        finalize(() => {
          this.busyService.idle();
        })
      )
      .subscribe({
        next: (res) => {
          this.agendarReserva();
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

  agendarReserva() {
    this.alertsService.fireConfirmCodeNumber(
      'question',
      'Código de verificación',
      'Por favor, ingrese el código recibido',
      (otp: string) => {
        this.reserveRequestDto = {
          agenda_id: this.horariosSeleccionados.map((h) => h.id!),
          otp: otp,
        };

        this.agendaService
          .reservar(this.reserveRequestDto)
          .pipe(takeUntilDestroyed(this.destroyRef))
          .subscribe({
            next: (res) => {
              this.alertsService.toast(
                'success',
                'La reserva fue agendada correctamente.'
              );

              this.dialogRef.close();
            },
            error: (err) => {
              const errorDto = new MessageExceptionDto({
                status: err.error?.status,
                error: err.error?.error,
                recommendation: err.error?.recommendation,
              });

              this.alertsService.fireError2(errorDto, () => {
                this.agendarReserva();
              });
            },
          });
      }
    );
  }
}

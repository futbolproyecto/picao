// Core
import {
  ChangeDetectionStrategy,
  Component,
  DestroyRef,
  inject,
  Inject,
  OnInit,
} from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  AbstractControl,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
} from '@angular/forms';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { finalize } from 'rxjs';

// Librerias
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { NgSelectModule } from '@ng-select/ng-select';

// Services
import { AlertsService } from '../../../core/service/alerts.service';
import { AgendaService } from '../../../core/service/agenda.service';
import { BusyService } from '../../../core/busy.service';

// Dto
import { MessageExceptionDto } from '../../../data/schema/MessageExceptionDto';
import { ChangeReservationStatusRequestDto } from '../../../data/schema/changeReservationStatusRequestDto';

@Component({
  selector: 'app-reservation-information-modal',
  standalone: true,
  imports: [CommonModule, MatDialogModule, NgSelectModule, ReactiveFormsModule],
  templateUrl: './reservation-information-modal.component.html',
  styleUrls: ['./reservation-information-modal.component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ReservationInformationModalComponent implements OnInit {
  public formularioInformacion: UntypedFormGroup = new UntypedFormGroup({});
  private formBuilder = inject(UntypedFormBuilder);
  private alertsService = inject(AlertsService);
  private agendaService = inject(AgendaService);
  private destroyRef = inject(DestroyRef);
  private busyService = inject(BusyService);

  public estadoAgendaOptions: { label: string; value: string }[] = [];
  public changeReservationStatusRequestDto: ChangeReservationStatusRequestDto =
    new ChangeReservationStatusRequestDto();

  constructor(
    public dialogRef: MatDialogRef<ReservationInformationModalComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
  ) {
    console.log(this.data);
    this.buildForm();
  }

  ngOnInit(): void {
    this.consultarEstadosAgenda();
    this.formularioInformacion.get('estado')?.setValue('SELECCIONE');
  }

  buildForm(): void {
    this.formularioInformacion = this.formBuilder.group({
      estado: [],
    });
  }

  get estado(): AbstractControl {
    return this.formularioInformacion.get('estado')!;
  }

  cerrar() {
    this.dialogRef.close();
  }

  cambiarEstado() {
    if (this.formularioInformacion.valid) {
      if (this.estado.value == 'SELECCIONE') {
        this.alertsService.toast('error', 'Debes seleccionar un estado');
        return;
      }

      if (this.estado.value === 'CANCELADO') {
        this.alertsService.fireConfirm(
          'warning',
          '',
          '¿Estás seguro de que deseas cancelar esta reserva?',
          () => {
            this.procesarCambioEstado();
          },
          () => {
            this.dialogRef.close();
          },
        );
      } else {
        this.procesarCambioEstado();
      }
    }
  }

  private procesarCambioEstado() {
    this.changeReservationStatusRequestDto = {
      agenda_id: this.data.id,
      agenda_status: this.estado.value,
    };

    this.busyService.busy();
    this.agendaService
      .cambiarEstadosAgenda(this.changeReservationStatusRequestDto)
      .pipe(
        takeUntilDestroyed(this.destroyRef),
        finalize(() => {
          this.busyService.idle();
        }),
      )
      .subscribe({
        next: () => {
          this.alertsService.toast(
            'success',
            '¡Reserva actualizada correctamente!',
          );
          this.dialogRef.close();
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

  consultarEstadosAgenda(): void {
    this.agendaService.obtenerEstadosAgenda().subscribe({
      next: (response) => {
        const opcionDefault = { label: 'Seleccione...', value: 'SELECCIONE' };

        const estadoActual = this.data.estado?.toUpperCase();

        const opciones = (response.payload as string[])
          .filter((estado) => estado !== estadoActual)
          .map((estado) => ({
            label: this.formatLabel(estado),
            value: estado,
          }));

        this.estadoAgendaOptions = [opcionDefault, ...opciones];

        this.formularioInformacion.get('estado')?.setValue('SELECCIONE');
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

  private formatLabel(estado: string): string {
    return estado
      .replace(/_/g, ' ')
      .toLowerCase()
      .replace(/^\w/, (c) => c.toUpperCase());
  }
}

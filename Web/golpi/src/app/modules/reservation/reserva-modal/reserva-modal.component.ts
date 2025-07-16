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

// Librerias
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { NgSelectModule } from '@ng-select/ng-select';
import {
  AbstractControl,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
} from '@angular/forms';
import { AlertsService } from '../../../core/service/alerts.service';
import { AgendaService } from '../../../core/service/agenda.service';
import { MessageExceptionDto } from '../../../data/schema/MessageExceptionDto';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import { finalize } from 'rxjs';
import { BusyService } from '../../../core/busy.service';
import { ChangeReservationStatusRequestDto } from '../../../data/schema/changeReservationStatusRequestDto';

@Component({
  selector: 'app-reserva-modal',
  standalone: true,
  imports: [CommonModule, MatDialogModule, NgSelectModule, ReactiveFormsModule],
  templateUrl: './reserva-modal.component.html',
  styleUrls: ['./reserva-modal.component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class ReservaModalComponent implements OnInit {
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
    public dialogRef: MatDialogRef<ReservaModalComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any
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
          })
        )
        .subscribe({
          next: () => {
            this.alertsService.toast(
              'success',
              'El estado se cambio correctamente.'
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

import { Component, inject, OnInit } from '@angular/core';
import { FullCalendarModule } from '@fullcalendar/angular';
import interactionPlugin from '@fullcalendar/interaction';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import { CardComponent } from '../../../shared/components/custom/card/card.component';
import esLocale from '@fullcalendar/core/locales/es';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { ModalScheduleSettingsComponent } from './modal-schedule-settings/modal-schedule-settings.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ScheduleService } from '../../../core/service/schedule.service';
import { AlertsService } from '../../../core/service/alerts.service';

@Component({
  selector: 'app-schedule-settings',
  standalone: true,
  imports: [
    FullCalendarModule,
    CardComponent,
    MatDialogModule,
    ReactiveFormsModule,
    FormsModule,
  ],
  templateUrl: './schedule-settings.component.html',
  styleUrl: './schedule-settings.component.css',
})
export class ScheduleSettingsComponent implements OnInit {
  private scheduleService = inject(ScheduleService);
  private alertsService = inject(AlertsService);

  constructor(private dialog: MatDialog) {}

  ngOnInit() {
    this.obtenerEventos();
  }

  obtenerEventos() {
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

    this.scheduleService
      .obtenerEventosPorEstablecimiento(idEstablecimiento)
      .subscribe((eventos) => {
        this.calendarOptions.events = eventos.map((e) => ({
          title: `Disponible - $${e.fee}`,
          start: `${e.fecha_inicio}T${e.hora_inicio}`,
          end: `${e.fecha_fin}T${e.hora_fin}`,
          color: '#4caf50',
          textColor: 'white',
        }));
      });
  }

  calendarOptions = {
    plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
    initialView: 'timeGridWeek',
    locale: esLocale,
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay',
    },
    allDaySlot: false,
    slotMinTime: '06:00:00',
    slotMaxTime: '22:00:00',
    slotDuration: '01:00:00',
    snapDuration: '01:00:00',
    selectable: true,
    select: this.handleDateSelect.bind(this),
    eventClick: this.handleDateSelect.bind(this),
    editable: true,
    events: [
      {
        title: 'Disponible',
        start: '2025-06-10T09:00:00',
        end: '2025-06-10T10:00:00',
        color: '#4caf50',
        textColor: 'white',
      },
    ],
  };

  handleDateSelect(selectInfo: any) {
    const startDate = new Date(selectInfo.startStr);
    const endDate = new Date(selectInfo.endStr);

    const formatDate = (date: Date): string => {
      const day = String(date.getDate()).padStart(2, '0');
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const year = date.getFullYear();
      return `${day}-${month}-${year}`;
    };

    const formatTime = (date: Date): string => {
      const hours = String(date.getHours()).padStart(2, '0');
      const minutes = String(date.getMinutes()).padStart(2, '0');
      const seconds = String(date.getSeconds()).padStart(2, '0');
      return `${hours}:${minutes}:${seconds}`;
    };

    const daysOfWeek = [
      'domingo',
      'lunes',
      'martes',
      'miércoles',
      'jueves',
      'viernes',
      'sábado',
    ];
    const dayName = daysOfWeek[startDate.getDay()];

    const dialogRef = this.dialog.open(ModalScheduleSettingsComponent, {
      disableClose: true,
      width: '700px',
      data: {
        startDate: formatDate(startDate),
        endDate: formatDate(endDate),
        startTime: formatTime(startDate),
        endTime: formatTime(endDate),
        dayName: dayName,
      },
    });

    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        this.calendarOptions.events = [
          ...this.calendarOptions.events,
          {
            title: 'Nuevo horario',
            start: selectInfo.startStr,
            end: selectInfo.endStr,
            color: '#2196f3',
            textColor: 'white',
          },
        ];
      }
    });
  }
}

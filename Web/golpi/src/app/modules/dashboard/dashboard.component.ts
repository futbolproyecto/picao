import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FullCalendarModule } from '@fullcalendar/angular';

import { CardComponent } from '../../shared/components/custom/card/card.component';
import { MatCardModule } from '@angular/material/card';
import { ReservaModalComponent } from '../reserva-modal/reserva-modal.component';
import { MatDialog } from '@angular/material/dialog';

import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import esLocale from '@fullcalendar/core/locales/es';
@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, FullCalendarModule, CardComponent, MatCardModule],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent {
  public totalTurnos = 50;
  public turnosPendientes = 15;
  public turnosConfirmados = 35;
  public turnosFinalizados = 10;
  public turnosSinConfirmar = 5;

  constructor(private dialog: MatDialog) {}

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
    events: [
      {
        title: 'Cancha 1 - Confirmado',
        start: '2025-03-10T13:00:00',
        end: '2025-03-10T14:00:00',
        color: '#4caf50',
        textColor: 'black',
        extendedProps: {
          cancha: 'Cancha 1',
          tipo: 'Sintética',
          cliente: 'Juan Pérez',
          estado: 'Confirmado',
        },
      },
      {
        title: 'Cancha 2 - Reservado',
        start: '2025-03-11T09:00:00',
        end: '2025-03-11T10:00:00',
        color: '#ff9800',
        textColor: 'black',
        extendedProps: {
          cancha: 'Cancha 2',
          tipo: 'Césped natural',
          cliente: 'Carlos Gómez',
          estado: 'Reservado',
        },
      },
      {
        title: 'Cancha 3 - Pendiente',
        start: '2025-03-12T10:00:00',
        end: '2025-03-11T11:00:00',
        color: '#ffff00',
        textColor: 'black',
        extendedProps: {
          cancha: 'Cancha 3',
          tipo: 'Cemento',
          cliente: 'Andrea Isaza',
          estado: 'Pendiente',
        },
      },
    ],
    eventClick: this.abrirModal.bind(this),
  };

  abrirModal(eventInfo: any) {
    const turno = eventInfo.event.extendedProps;
    this.dialog.open(ReservaModalComponent, {
      data: {
        cancha: turno.cancha,
        tipo: turno.tipo,
        cliente: turno.cliente,
        estado: turno.estado,
        hora: eventInfo.event.start,
      },
    });
  }
}

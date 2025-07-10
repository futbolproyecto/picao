// Core
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DateSelectArg, EventClickArg } from '@fullcalendar/core';

// Librerias
import { MatDialog } from '@angular/material/dialog';
import { FullCalendarModule } from '@fullcalendar/angular';
import { MatCardModule } from '@angular/material/card';

// Compatidos
import { CardComponent } from '../../shared/components/custom/card/card.component';

// Componentes
import { ReservaModalComponent } from '../reserva-modal/reserva-modal.component';
import { ModalReservationComponent } from './modal-reservation/modal-reservation.component';

import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import esLocale from '@fullcalendar/core/locales/es';

@Component({
  selector: 'app-reservacion',
  standalone: true,
  imports: [CardComponent, CommonModule, FullCalendarModule, MatCardModule],
  templateUrl: './reservation.component.html',
  styleUrl: './reservation.component.css',
})
export class ReservationComponent {
  public AdministrarActivo: boolean = true;
  public nombrePestana: string = 'Administrar reservaciones';

  public totalTurnos = 50;
  public turnosPendientes = 15;
  public turnosConfirmados = 35;
  public turnosFinalizados = 10;
  public turnosSinConfirmar = 5;

  activarPestana(pestana: string): void {
    if (pestana === 'administrar') {
      this.nombrePestana = 'Administrar reservaciones';
      this.AdministrarActivo = true;
    }
  }

  constructor(private dialog: MatDialog) {}

  calendarOptions: any = {
    plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
    initialView: 'timeGridWeek',
    locale: esLocale,
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay',
    },
    allDaySlot: false,
    slotMinTime: '00:00:00',
    slotMaxTime: '23:00:00',
    slotDuration: '01:00:00',
    snapDuration: '01:00:00',
    events: [],
    selectable: true,
    selectMirror: true,

    select: (selectInfo: DateSelectArg) => {
      this.abrirModalNuevaReserva(selectInfo);
    },

    eventClick: (info: EventClickArg) => {
      if (info.event.extendedProps['isBackground']) return;
      this.abrirModal(info);
    },
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

  abrirModalNuevaReserva(selectInfo: any) {
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

    this.dialog.open(ModalReservationComponent, {
      disableClose: true,
      width: '700px',
      data: {
        startDate: formatDate(startDate),
        endDate: formatDate(endDate),
        startTime: formatTime(startDate),
        endTime: formatTime(endDate),
      },
    });
  }
}

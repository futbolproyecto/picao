// Core
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DateSelectArg, EventClickArg } from '@fullcalendar/core';

// Librerias
import { MatDialog } from '@angular/material/dialog';
import { FullCalendarModule } from '@fullcalendar/angular';
import { MatCardModule } from '@angular/material/card';

// Compatidos
import { CardComponent } from '../../shared/components/custom/card/card.component';

// Componentes
import { ReservaModalComponent } from './reserva-modal/reserva-modal.component';
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
export class ReservationComponent implements OnInit {
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

  ngOnInit(): void {
    this.calendarEvents.push(
      {
        title: 'Reserva Cancha 1',
        start: '2025-07-12T10:00:00',
        end: '2025-07-12T11:00:00',
        color: '#5bc0de',
        extendedProps: {
          cancha: 'Cancha 1',
          tipo: 'Fútbol 5',
          cliente: 'Juan',
          estado: 'Reservada',
        },
      },
      {
        title: 'Reserva Cancha 2',
        start: '2025-07-12T12:00:00',
        end: '2025-07-12T13:00:00',
        color: '#5cb85c',
        extendedProps: {
          cancha: 'Cancha 2',
          tipo: 'Fútbol 7',
          cliente: 'Andrea',
          estado: 'Confirmada',
        },
      }
    );
  }

  constructor(private dialog: MatDialog) {}

  calendarEvents: any[] = [];

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
    slotMinTime: '06:00:00',
    slotMaxTime: '23:00:00',
    slotDuration: '01:00:00',
    snapDuration: '01:00:00',
    events: this.calendarEvents,
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
    const startDate = new Date(eventInfo.event.start);

    const turno = eventInfo.event.extendedProps;
    this.dialog.open(ReservaModalComponent, {
      disableClose: true,
      width: '700px',
      data: {
        cancha: turno.cancha,
        tipo: turno.tipo,
        cliente: turno.cliente,
        estado: turno.estado,
        fecha: this.formatDate(startDate),
        hora: this.formatTime(startDate),
      },
    });
  }

  abrirModalNuevaReserva(selectInfo: any) {
    const startDate = new Date(selectInfo.start);
    const endDate = new Date(selectInfo.end);

    this.dialog.open(ModalReservationComponent, {
      disableClose: true,
      width: '700px',
      data: {
        startDate: this.formatDate(startDate),
        endDate: this.formatDate(endDate),
        startTime: this.formatTime(startDate),
        endTime: this.formatTime(endDate),
      },
    });
  }

  formatDate = (date: Date): string => {
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();
    return `${day}-${month}-${year}`;
  };

  formatTime = (date: Date): string => {
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');
    return `${hours}:${minutes}:${seconds}`;
  };
}

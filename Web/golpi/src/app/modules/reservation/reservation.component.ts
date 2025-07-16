// Core
import { Component, inject, OnInit } from '@angular/core';
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
import { AlertsService } from '../../core/service/alerts.service';
import { AgendaService } from '../../core/service/agenda.service';

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
    this.cargarReservas();
  }

  constructor(
    private dialog: MatDialog,
    private reservaService: AgendaService
  ) {}

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
    const dialogRef = this.dialog.open(ReservaModalComponent, {
      disableClose: true,
      width: '700px',
      data: {
        fecha: this.formatDate2(startDate),
        hora: this.formatTime(startDate),
        user_name: turno.user_name,
        user_last_name: turno.user_last_name,
        mobile_number: turno.mobile_number,
        name_field: turno.name_field,
        id: turno.id,
        estado: turno.estado,
      },
    });

    dialogRef.afterClosed().subscribe(() => {
      this.cargarReservas();
    });
  }

  abrirModalNuevaReserva(selectInfo: any) {
    const startDate = new Date(selectInfo.start);
    const endDate = new Date(selectInfo.end);

    const dialogRef = this.dialog.open(ModalReservationComponent, {
      disableClose: true,
      width: '700px',
      data: {
        startDate: this.formatDate(startDate),
        endDate: this.formatDate(endDate),
        startTime: this.formatTime(startDate),
        endTime: this.formatTime(endDate),
      },
    });

    dialogRef.afterClosed().subscribe(() => {
      this.cargarReservas();
    });
  }

  formatDate = (date: Date): string => {
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();
    return `${day}-${month}-${year}`;
  };

  formatDate2 = (date: Date): string => {
    const day = String(date.getDate()).padStart(2, '0');
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const year = date.getFullYear();
    return `${year}-${month}-${day}`;
  };

  formatTime = (date: Date): string => {
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');
    return `${hours}:${minutes}:${seconds}`;
  };

  cargarReservas() {
    const idEstablecimiento = localStorage.getItem(
      'establecimientoSeleccionado'
    );

    this.reservaService
      .cargarReservas(idEstablecimiento!)
      .subscribe((response) => {
        const reservas = response.payload;
        const eventos = reservas.map((reserva: any) => {
          const startDateTime = `${reserva.date}T${reserva.start_time}`;

          return {
            title: `${reserva.name_field}`,
            start: startDateTime,
            color: this.obtenerColorPorEstado(reserva.status),
            textColor: 'black',
            extendedProps: {
              user_name: reserva.user_name,
              user_last_name: reserva.user_last_name,
              mobile_number: reserva.mobile_number,
              name_field: reserva.name_field,
              id: reserva.id,
              estado: reserva.status,
            },
          };
        });

        this.calendarOptions.events = eventos;
      });
  }

  obtenerColorPorEstado(estado: string): string {
    switch (estado) {
      case 'DISPONIBLE':
        return '#17a2b8';
      case 'RESERVADO':
        return '#0275d8';
      case 'CONFIRMADO':
        return '#28a745';
      case 'BLOQUEADO':
        return '#6f42c1';
      case 'PAGADO':
        return '#ffc107';
      case 'INASISTIDO':
        return '#6c757d';
      case 'NO_PAGADO':
        return '#fd7e14';
      case 'CANCELADO':
        return '#dc3545';
      default:
        return '#343a40';
    }
  }
}

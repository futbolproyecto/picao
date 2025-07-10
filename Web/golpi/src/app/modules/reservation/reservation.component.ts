// Core
import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';

// Librerias
import { MatDialog } from '@angular/material/dialog';

// Compatidos
import { CardComponent } from '../../shared/components/custom/card/card.component';

// Componentes
import { FullCalendarModule } from '@fullcalendar/angular';
import { MatCardModule } from '@angular/material/card';

import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import esLocale from '@fullcalendar/core/locales/es';
import { ReservaModalComponent } from '../reserva-modal/reserva-modal.component';
import { AgendaService } from '../../core/service/agenda.service';
import { AlertsService } from '../../core/service/alerts.service';
import { DateSelectArg, EventClickArg } from '@fullcalendar/core';
import { ModalReservationComponent } from './modal-reservation/modal-reservation.component';

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
  private alertsService = inject(AlertsService);

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
    // this.cargarReservas();
    this.cargarDisponibilidad();
  }

  constructor(
    private dialog: MatDialog,
    private reservaService: AgendaService
  ) {}

  // calendarOptions = {
  //   plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
  //   initialView: 'timeGridWeek',
  //   locale: esLocale,
  //   headerToolbar: {
  //     left: 'prev,next today',
  //     center: 'title',
  //     right: 'dayGridMonth,timeGridWeek,timeGridDay',
  //   },
  //   allDaySlot: false,
  //   events: [
  //     {
  //       title: 'Cancha 1 - Confirmado',
  //       start: '2025-03-10T13:00:00',
  //       end: '2025-03-10T14:00:00',
  //       color: '#4caf50',
  //       textColor: 'black',
  //       extendedProps: {
  //         cancha: 'Cancha 1',
  //         tipo: 'Sintética',
  //         cliente: 'Juan Pérez',
  //         estado: 'Confirmado',
  //       },
  //     },
  //     {
  //       title: 'Cancha 2 - Reservado',
  //       start: '2025-03-11T09:00:00',
  //       end: '2025-03-11T10:00:00',
  //       color: '#ff9800',
  //       textColor: 'black',
  //       extendedProps: {
  //         cancha: 'Cancha 2',
  //         tipo: 'Césped natural',
  //         cliente: 'Carlos Gómez',
  //         estado: 'Reservado',
  //       },
  //     },
  //     {
  //       title: 'Cancha 3 - Pendiente',
  //       start: '2025-03-12T10:00:00',
  //       end: '2025-03-11T11:00:00',
  //       color: '#ffff00',
  //       textColor: 'black',
  //       extendedProps: {
  //         cancha: 'Cancha 3',
  //         tipo: 'Cemento',
  //         cliente: 'Andrea Isaza',
  //         estado: 'Pendiente',
  //       },
  //     },
  //   ],
  //   eventClick: this.abrirModal.bind(this),
  // };

  // abrirModal(eventInfo: any) {
  //   const turno = eventInfo.event.extendedProps;
  //   this.dialog.open(ReservaModalComponent, {
  //     data: {
  //       cancha: turno.cancha,
  //       tipo: turno.tipo,
  //       cliente: turno.cliente,
  //       estado: turno.estado,
  //       hora: eventInfo.event.start,
  //     },
  //   });
  // }

  // Tu calendario

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

    selectAllow: (selectInfo: DateSelectArg) => {
      const seleccionInicio = selectInfo.start;
      const seleccionFin = selectInfo.end;

      return !this.bloquesNoDisponibles.some((bloque) => {
        return seleccionInicio < bloque.end && seleccionFin > bloque.start;
      });
    },
  };

  // cargarReservas() {
  //   const idEstablecimiento = localStorage.getItem(
  //     'establecimientoSeleccionado'
  //   );

  //   if (!idEstablecimiento) {
  //     this.alertsService.toast(
  //       'error',
  //       'No se ha seleccionado un establecimiento.'
  //     );
  //     return;
  //   }

  //   this.reservaService
  //     .cargarAgenda(idEstablecimiento)
  //     .subscribe((response) => {
  //       console.log(response);
  //       const reservas = response.payload;
  //       const eventos = reservas.map((reserva: any) => {
  //         const startDateTime = `${reserva.date}T${reserva.start_time}`;

  //         return {
  //           title: `${reserva.start_time} - ${reserva.status}`,
  //           start: startDateTime,
  //           end: startDateTime, // si no tienes una hora de fin, usa la misma o calcula duración estimada
  //           color: this.obtenerColorPorEstado(reserva.status),
  //           textColor: 'black',
  //           extendedProps: {
  //             fee: reserva.fee,
  //             dia: reserva.day_of_week,
  //             id: reserva.id,
  //             estado: reserva.status,
  //           },
  //         };
  //       });

  //       this.calendarOptions.events = [
  //         ...this.calendarOptions.events,
  //         ...eventos,
  //       ];
  //     });
  // }

  bloquesNoDisponibles: { start: Date; end: Date }[] = [];

  cargarDisponibilidad() {
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

    this.reservaService
      .cargarDisponibilidad(idEstablecimiento)
      .subscribe((response) => {
        console.log(response);
        const bloquesDisponibles = response.payload;

        // Agrupar disponibilidad por fecha
        const disponibilidadPorDia: { [fecha: string]: string[] } = {};

        bloquesDisponibles.forEach((bloque: any) => {
          const fecha = bloque.date;
          if (!disponibilidadPorDia[fecha]) disponibilidadPorDia[fecha] = [];
          disponibilidadPorDia[fecha].push(bloque.start_time);
        });

        const eventosNoDisponibles: any[] = [];

        const generarHoras = (start: string, end: string): string[] => {
          const horas: string[] = [];
          let hora = new Date(`1970-01-01T${start}`);
          const fin = new Date(`1970-01-01T${end}`);

          while (hora < fin) {
            horas.push(hora.toTimeString().substring(0, 8)); // HH:mm:ss
            hora = new Date(hora.getTime() + 60 * 60 * 1000); // sumar 1 hora
          }

          return horas;
        };

        Object.entries(disponibilidadPorDia).forEach(
          ([fecha, horasDisponibles]) => {
            const todasLasHoras = generarHoras('00:00:00', '23:00:00');

            const horasNoDisponibles = todasLasHoras.filter(
              (hora) => !horasDisponibles.includes(hora)
            );

            horasNoDisponibles.forEach((hora) => {
              const start = `${fecha}T${hora}`;
              const end = new Date(
                new Date(start).getTime() + 60 * 60 * 1000
              ).toISOString();

              eventosNoDisponibles.push({
                title: 'No disponible',
                start,
                end,
                display: 'background', // correcto en FullCalendar v5+
                color: '#e0e0e0',
                overlap: false,
                extendedProps: {
                  isBackground: true,
                },
              });
            });
          }
        );

        // Guardar los rangos no disponibles para bloquear selección
        this.bloquesNoDisponibles = eventosNoDisponibles.map((e) => ({
          start: new Date(e.start),
          end: new Date(e.end),
        }));

        // Añadir al calendario
        this.calendarOptions.events = [
          ...this.calendarOptions.events,
          ...eventosNoDisponibles,
        ];
      });
  }

  obtenerColorPorEstado(estado: string): string {
    switch (estado) {
      case 'DISPONIBLE':
        return '#ff9800';
      case 'confirmada':
        return '#4caf50';
      case 'pagada':
        return '#2196f3';
      case 'ausente':
        return '#f44336';
      case 'no pagada':
      case 'sin pagar':
        return '#9e9e9e';
      default:
        return '#000';
    }
  }

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

    const dialogRef = this.dialog.open(ModalReservationComponent, {
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

  verificarDisponibilidad(start: Date, end: Date): boolean {
    // Aquí podrías verificar contra la disponibilidad cargada previamente (opcional)
    return true; // Lógica más específica puede ser agregada
  }
}

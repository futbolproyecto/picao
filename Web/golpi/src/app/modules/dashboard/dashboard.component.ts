import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { FullCalendarModule } from '@fullcalendar/angular';
import { CalendarOptions } from '@fullcalendar/core';
import { CardComponent } from '../../shared/components/custom/card/card.component';

import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import esLocale from '@fullcalendar/core/locales/es';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, MatCardModule, FullCalendarModule, CardComponent],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent {
  totalTurnos = 50;
  turnosPendientes = 15;
  turnosConfirmados = 35;

  calendarOptions: CalendarOptions = {
    plugins: [dayGridPlugin, timeGridPlugin],
    initialView: 'dayGridMonth',
    locale: esLocale,
    height: '500px',
    contentHeight: 'auto',
    events: [
      {
        title: 'Turno 1',
        start: '2025-01-20T10:00:00',
        end: '2025-01-20T11:00:00',
        color: 'green',
      },
      {
        title: 'Turno 2',
        start: '2025-01-20T11:00:00',
        end: '2024-12-20T12:00:00',
        color: 'green',
      },
      {
        title: 'Turno ',
        start: '2025-01-21T14:00:00',
        end: '2025-01-21T15:00:00',
        color: 'orange',
      },
    ],
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay',
    },
    selectable: true,
    editable: true,
  };
}

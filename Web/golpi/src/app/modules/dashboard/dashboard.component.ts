import { CommonModule } from '@angular/common';
import { Component, model } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { FullCalendarModule } from '@fullcalendar/angular';
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { MatDatepickerModule } from '@angular/material/datepicker'; // Asegúrate de importar MatNativeDateModule
import { MatNativeDateModule } from '@angular/material/core';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [
    CommonModule,
    MatCardModule,
    FullCalendarModule,
    CardComponent,
    MatDatepickerModule,
    MatNativeDateModule,
  ],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent {
  public totalTurnos = 50;
  public turnosPendientes = 15;
  public turnosConfirmados = 35;

  public selected = model<Date | null>(null);
}

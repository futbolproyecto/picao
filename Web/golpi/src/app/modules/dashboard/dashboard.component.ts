// Core
import { CommonModule } from '@angular/common';
import { Component, inject } from '@angular/core';

// Librerias
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';

// Compartidos
import { MatCardModule } from '@angular/material/card';
import { CardComponent } from '../../shared/components/custom/card/card.component';

// Componentes
import { ReservaModalComponent } from '../reserva-modal/reserva-modal.component';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [
    CommonModule,
    MatCardModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatDialogModule,
    CardComponent,
  ],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent {
  public totalTurnos = 50;
  public turnosPendientes = 15;
  public turnosConfirmados = 35;

  public selected: Date | null = null;
  private dialog = inject(MatDialog);

  // Simulación de reservas
  public reservas = [
    {
      fecha: new Date(2025, 1, 10),
      nombre: 'Juan Pérez',
      hora: '10:00 AM',
      estado: 'Confirmado',
    },
    {
      fecha: new Date(2025, 1, 10),
      nombre: 'María López',
      hora: '2:30 PM',
      estado: 'Pendiente',
    },
    {
      fecha: new Date(2025, 1, 14),
      nombre: 'Carlos Gómez',
      hora: '4:00 PM',
      estado: 'Reservado',
    },
  ];

  onDateSelected(date: Date | null) {
    if (date) {
      const dayReservations = this.reservas.filter(
        (res) => res.fecha.toDateString() === date.toDateString()
      );

      if (dayReservations.length > 0) {
        this.dialog.open(ReservaModalComponent, {
          data: { date, reservas: dayReservations },
          width: '400px',
        });
      }
    }
  }
}

import { CommonModule } from '@angular/common';
import { Component, inject } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { ReservaModalComponent } from '../reserva-modal/reserva-modal.component';
import { CardComponent } from '../../shared/components/custom/card/card.component';

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
      fecha: new Date('2025-02-10'),
      nombre: 'Juan Pérez',
      hora: '10:00 AM',
      estado: 'Confirmado',
    },
    {
      fecha: new Date(2025, 2, 15),
      nombre: 'María López',
      hora: '2:30 PM',
      estado: 'Pendiente',
    },
    {
      fecha: new Date('11-02-2025'),
      nombre: 'Carlos Gómez',
      hora: '4:00 PM',
      estado: 'Reservado',
    },
  ];

  openDialog() {
    if (!this.selected) return;

    const reserva = this.reservas.find(
      (r) => r.fecha.toDateString() === this.selected!.toDateString()
    );

    if (reserva) {
      this.dialog.open(ReservaModalComponent, { data: reserva });
    }
  }
}

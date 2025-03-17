import { Component, signal, WritableSignal } from '@angular/core';
import { MatTableModule } from '@angular/material/table';
import { CommonModule } from '@angular/common';
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { DataTableComponent } from '../../shared/components/custom/data-table/data-table.component';

@Component({
  selector: 'app-notifications',
  standalone: true,
  imports: [CommonModule, MatTableModule, CardComponent, DataTableComponent],
  templateUrl: './notifications.component.html',
  styleUrl: './notifications.component.css',
})
export class NotificationsComponent {
  // private notificacionService = inject(NotificationService);

  solicitudes: WritableSignal<any[]> = signal([]);

  public encabezadosSolicitud = {
    fecha: 'Fecha',
    hora: 'Hora',
    nombre: 'Nombre cliente',
    celular: 'Celular',
    correo: 'Correo electrónico',
    cancha: 'Cancha',
    acciones: 'Acciones',
  };

  tablaSolicitud = [
    {
      fecha: '2024-12-19',
      hora: '13:00',
      nombre: 'Dulce Isaza',
      celular: '1234567890',
      correo: 'dulce@gmail.com',
      cancha: 'Cancha 2',
    },
    {
      fecha: '2024-12-20',
      hora: '14:00',
      nombre: 'Andrea Isaza',
      celular: '0987654321',
      correo: 'andrea@hotmail.com',
      cancha: 'Cancha 1',
    },
  ];

  ngOnInit() {
    // this.notificacionService.obtenerSolicitudes().subscribe((solicitudes) => {
    //   this.solicitudes.set(solicitudes);
    // });
  }
}

// Core
import { Component, inject } from '@angular/core';

// Librerias
import { MatTooltipModule } from '@angular/material/tooltip';

// Servicios
import { AlertsService } from '../../../../core/service/alerts.service';
import { AuthService } from '../../../../core/service/auth.service';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [MatTooltipModule],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css',
})
export class NavbarComponent {
  private alertsService = inject(AlertsService);
  public authService = inject(AuthService);

  CerrarSesion() {
    this.alertsService.fireConfirm(
      'error',
      'Esta seguro de cerrar sesión?',
      'Al cerrarla, tendrá que autenticarse de nuevo para realizar alguna operación!',
      () => {
        this.authService.cerrarSesion();
      }
    );
  }
}

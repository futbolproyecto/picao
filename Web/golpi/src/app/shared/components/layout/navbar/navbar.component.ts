// Core
import { Component, inject, OnInit } from '@angular/core';

// Librerias
import { MatTooltipModule } from '@angular/material/tooltip';

// Servicios
import { AlertsService } from '../../../../core/service/alerts.service';
import { AuthService } from '../../../../core/service/auth.service';
import { RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatMenuModule } from '@angular/material/menu';
import { UserResponseDto } from '../../../../data/schema/userResponseDto';
import { AutenticacionStoreService } from '../../../../core/store/auth/autenticacion-store.service';
import { filter, map, Observable, switchMap } from 'rxjs';
import { UserService } from '../../../../core/service/user.service';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [
    MatTooltipModule,
    RouterModule,
    CommonModule,
    MatIconModule,
    MatButtonModule,
    MatMenuModule,
  ],
  templateUrl: './navbar.component.html',
  styleUrl: './navbar.component.css',
})
export class NavbarComponent implements OnInit {
  private alertsService = inject(AlertsService);
  private autenticacionStoreService = inject(AutenticacionStoreService);
  public usuario: UserResponseDto = new UserResponseDto();
  public authService = inject(AuthService);
  private userService = inject(UserService);

  public nombreMostrar: string = '';
  public tieneEstablecimiento: boolean = true;

  ngOnInit() {
    const authDataString = sessionStorage.getItem('authentication');
    if (authDataString) {
      const authData = JSON.parse(authDataString);
      this.usuario.id = authData.id;

      this.userService.getById(authData.id).subscribe({
        next: (response) => {
          if (response?.payload) {
            this.usuario = response.payload;
            this.nombreMostrar = `${this.usuario.name} ${this.usuario.last_name}`;
          }
        },
        error: () => {},
      });
    }

    this.autenticacionStoreService.tieneEstablecimiento$.subscribe((valor) => {
      this.tieneEstablecimiento = valor;
    });
  }

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

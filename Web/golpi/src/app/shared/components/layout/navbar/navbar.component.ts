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
import { UsuarioResponseDto } from '../../../../data/schema/userResponseDto';
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
  private usuario$: Observable<UsuarioResponseDto> =
    new Observable<UsuarioResponseDto>();
  public usuario: UsuarioResponseDto = new UsuarioResponseDto();
  public authService = inject(AuthService);
  private userService = inject(UserService);

  public nombreMostrar: string = '';

  constructor() {
    this.usuario$ = this.autenticacionStoreService.obtenerSesion$();
  }

  ngOnInit() {
    this.consultarUsuario();
  }

  consultarUsuario(): void {
    this.usuario$
      .pipe(
        map((usuario: UsuarioResponseDto) => usuario?.id ?? 0),
        filter((id: number) => id !== 0),
        switchMap((id: number) => this.userService.getById(id))
      )
      .subscribe({
        next: (response) => {
          if (response?.payload) {
            this.usuario = response.payload;
            this.nombreMostrar = `${this.usuario.name} ${this.usuario.last_name}`;
          }
        },
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

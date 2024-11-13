import { CommonModule } from '@angular/common';
import { Component, inject, OnInit } from '@angular/core';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatButtonModule } from '@angular/material/button';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { AlertsService } from '../../../../core/service/alerts.service';
import { AuthService } from '../../../../core/service/auth.service';
import { Observable } from 'rxjs';
import { UsuarioResponseDto } from '../../../../data/schema/userResponseDto';
import { AutenticacionStoreService } from '../../../../core/store/auth/autenticacion-store.service';
import { UserService } from '../../../../core/service/user.service';
import { catchError, map, switchMap } from 'rxjs/operators'; // Para usar switchMap

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [
    CommonModule,
    MatIconModule,
    MatSidenavModule,
    MatButtonModule,
    MatListModule,
  ],
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css',
})
export class SidebarComponent implements OnInit {
  private autenticacionStoreService = inject(AutenticacionStoreService);
  private alertsService = inject(AlertsService);
  public authService = inject(AuthService);
  private usuario$: Observable<UsuarioResponseDto> =
    new Observable<UsuarioResponseDto>();
  private userService = inject(UserService);

  public usuario: UsuarioResponseDto = new UsuarioResponseDto();
  public mostrarSubmodulosUsuario: boolean = false;
  public nombreMostrar: string = '';

  constructor() {
    this.usuario$ = this.autenticacionStoreService.obtenerSesion$();
  }

  ngOnInit() {
    this.consultarUsuario();
  }

  toggleSubmodulosUsuario(): void {
    this.mostrarSubmodulosUsuario = !this.mostrarSubmodulosUsuario;
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

  consultarUsuario(): void {
    this.usuario$
      .pipe(
        map((usuario: UsuarioResponseDto) => usuario?.id ?? 0),

        switchMap((id: number) => this.userService.getById(id))
      )
      .subscribe({
        next: (response) => {
          if (response?.payload) {
            this.usuario = response.payload;
            this.nombreMostrar = `${this.usuario.name} ${this.usuario.lastName}`;
          }
        },
      });
  }
}

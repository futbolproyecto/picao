// Core
import { CommonModule } from '@angular/common';
import { Component, HostListener, inject, OnInit } from '@angular/core';
import { Observable } from 'rxjs';
import { filter, map, switchMap } from 'rxjs/operators';
import { RouterModule } from '@angular/router';

// Servicios
import { AutenticacionStoreService } from '../../../../core/store/auth/autenticacion-store.service';
import { UserService } from '../../../../core/service/user.service';

// Librerias
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatButtonModule } from '@angular/material/button';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';

// Dto
import { UsuarioResponseDto } from '../../../../data/schema/userResponseDto';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [
    CommonModule,
    MatIconModule,
    MatSidenavModule,
    MatButtonModule,
    MatListModule,
    RouterModule,
    MatTooltipModule,
  ],
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.css',
})
export class SidebarComponent implements OnInit {
  private autenticacionStoreService = inject(AutenticacionStoreService);
  private usuario$: Observable<UsuarioResponseDto> =
    new Observable<UsuarioResponseDto>();
  private userService = inject(UserService);

  public usuario: UsuarioResponseDto = new UsuarioResponseDto();
  public mostrarSubmodulosUsuario: boolean = false;
  public nombreMostrar: string = '';
  public menuExpandido: boolean = false;
  public menuMobile: boolean = false;
  public menuAbierto = false;

  constructor() {
    this.usuario$ = this.autenticacionStoreService.obtenerSesion$();
  }

  ngOnInit() {
    this.consultarUsuario();
    this.checkIfMobile();
  }

  @HostListener('window:resize', ['$event'])
  onResize(event: Event) {
    this.checkIfMobile();
  }

  private checkIfMobile(): void {
    if (window.innerWidth <= 768) {
      this.menuMobile = false;
    }
  }

  toggleSubmodulosUsuario(): void {
    this.mostrarSubmodulosUsuario = !this.mostrarSubmodulosUsuario;
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

  toggleMenuMobile(): void {
    this.menuMobile = !this.menuMobile;
  }

  closeMenuMobile(): void {
    if (window.innerWidth <= 768) {
      this.menuMobile = false;
    }
  }
}

// Core
import { CommonModule } from '@angular/common';
import { Component, HostListener, inject, OnInit } from '@angular/core';
import { NavigationEnd, RouterModule, Router } from '@angular/router';

// Servicios
import { AutenticacionStoreService } from '../../../../core/store/auth/autenticacion-store.service';

// Librerias
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatButtonModule } from '@angular/material/button';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';

// Dto
import { UserResponseDto } from '../../../../data/schema/userResponseDto';
import { AuthService } from '../../../../core/service/auth.service';
import { filter } from 'rxjs';

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
  private router = inject(Router);
  private autenticacionStoreService = inject(AutenticacionStoreService);
  public authService = inject(AuthService);
  public usuario: UserResponseDto = new UserResponseDto();
  public menuExpandido: boolean = false;
  public menuMobile: boolean = false;
  public menuAbierto = false;
  public tieneEstablecimiento: boolean = true;

  public currentUrl: string = '';
  public mostrarSubmodulosConfiguracion: boolean = false;

  ngOnInit() {
    this.checkIfMobile();

    this.autenticacionStoreService.tieneEstablecimiento$.subscribe((valor) => {
      this.tieneEstablecimiento = valor;
    });

    this.router.events
      .pipe(
        filter(
          (event): event is NavigationEnd => event instanceof NavigationEnd
        )
      )
      .subscribe((event) => {
        this.currentUrl = event.urlAfterRedirects;
        this.updateMenuState();
      });
  }

  updateMenuState() {
    // Lógica para actualizar el estado del submenú
    if (
      this.currentUrl === '/home/settings/user' ||
      this.currentUrl === '/home/settings/schedule-settings'
    ) {
      this.mostrarSubmodulosConfiguracion = true; // Expande el submenú
    } else {
      this.mostrarSubmodulosConfiguracion = false; // Contrae el submenú
    }
  }

  closeMenuMobile(): void {
    if (window.innerWidth <= 768) {
      this.menuMobile = false;
    }
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

  toggleSubmodulosConfiguracion() {
    // Alterna entre expandir y contraer el submenú
    this.mostrarSubmodulosConfiguracion = !this.mostrarSubmodulosConfiguracion;
  }

  toggleMenuMobile(): void {
    this.menuMobile = !this.menuMobile;
  }
}

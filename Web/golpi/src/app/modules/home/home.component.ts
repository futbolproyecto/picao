// Core
import { Component, inject, OnInit } from '@angular/core';
import { RouterModule } from '@angular/router';

// Componentes
import { FooterComponent } from '../../shared/components/layout/footer/footer.component';
import { SidebarComponent } from '../../shared/components/layout/sidebar/sidebar.component';
import { NavbarComponent } from '../../shared/components/layout/navbar/navbar.component';
import { AutenticacionStoreService } from '../../core/store/auth/autenticacion-store.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [
    FooterComponent,
    SidebarComponent,
    RouterModule,
    NavbarComponent,
    CommonModule,
  ],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css',
})
export class HomeComponent implements OnInit {
  private autenticacionStore = inject(AutenticacionStoreService);
  public tieneEstablecimiento: boolean = true;

  ngOnInit() {
    this.autenticacionStore.tieneEstablecimiento$.subscribe((valor) => {
      this.tieneEstablecimiento = valor;
    });
  }
}

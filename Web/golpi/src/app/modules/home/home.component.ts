import { Component } from '@angular/core';
import { FooterComponent } from '../../shared/components/layout/footer/footer.component';
import { SidebarComponent } from '../../shared/components/layout/sidebar/sidebar.component';
import { RouterModule } from '@angular/router';
import { NavbarComponent } from "../../shared/components/layout/navbar/navbar.component";

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [FooterComponent, SidebarComponent, RouterModule, NavbarComponent],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css',
})
export class HomeComponent {}

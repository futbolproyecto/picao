import { Component } from '@angular/core';
import { NavbarComponent } from "../../shared/components/layout/navbar/navbar.component";
import { FooterComponent } from "../../shared/components/layout/footer/footer.component";
import { SidebarComponent } from "../../shared/components/layout/sidebar/sidebar.component";

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [NavbarComponent, FooterComponent, SidebarComponent],
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {

}

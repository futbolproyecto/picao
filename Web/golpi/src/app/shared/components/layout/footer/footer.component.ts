// Core
import { Component } from '@angular/core';

@Component({
  selector: 'app-footer',
  standalone: true,
  imports: [],
  templateUrl: './footer.component.html',
  styleUrl: './footer.component.css',
})
export class FooterComponent {
  ngOnInit() {
    this.getTime();
  }

  public anio = new Date();
  public fechaActual: number = 0;

  getTime(): void {
    this.fechaActual = this.anio.getFullYear();
  }
}

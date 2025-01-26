import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-carousel',
  standalone: true,
  imports: [MatIconModule, CommonModule],
  templateUrl: './carousel.component.html',
  styleUrl: './carousel.component.css',
})
export class CarouselComponent {
  public activeIndex: number = 1;

  moverImagen(index: number) {
    this.activeIndex = index;
  }
}

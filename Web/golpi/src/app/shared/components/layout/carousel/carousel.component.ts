import { CommonModule } from '@angular/common';
import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-carousel',
  standalone: true,
  imports: [MatIconModule, CommonModule],
  templateUrl: './carousel.component.html',
  styleUrl: './carousel.component.css',
})
export class CarouselComponent implements OnInit, OnDestroy {
  public activeIndex: number = 1;
  private intervalId: any;
  private totalImages: number = 3;

  ngOnInit() {
    this.startAutoSlide();
  }

  ngOnDestroy() {
    this.stopAutoSlide();
  }

  moverImagen(index: number) {
    this.activeIndex = index;
    this.stopAutoSlide();
    this.startAutoSlide();
  }

  private startAutoSlide() {
    this.intervalId = setInterval(() => {
      this.activeIndex =
        this.activeIndex < this.totalImages ? this.activeIndex + 1 : 1;
    }, 5000);
  }

  private stopAutoSlide() {
    if (this.intervalId) {
      clearInterval(this.intervalId);
    }
  }
}

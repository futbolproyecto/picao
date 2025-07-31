// Core
import { Component, ElementRef, Input, Renderer2 } from '@angular/core';

@Component({
  selector: 'app-card',
  standalone: true,
  imports: [],
  templateUrl: './card.component.html',
  styleUrl: './card.component.css',
})
export class CardComponent {
  @Input() height?: string = '';
  @Input() width: string = '';
  @Input() margin?: string = '';

  constructor(private el: ElementRef, private renderer: Renderer2) {}

  ngAfterViewInit(): void {
    this.inicializarComponente();
  }

  inicializarComponente(): void {
    const divCard = this.el.nativeElement;
    this.renderer.setStyle(divCard, 'height', this.height || 'auto');
    this.renderer.setStyle(divCard, 'width', this.width || 'auto');
    this.renderer.setStyle(divCard, 'margin', this.margin || '0px');
    this.renderer.setStyle(divCard, 'border-radius', '30px');
    this.renderer.setStyle(divCard, 'overflow', 'hidden');
  }
}

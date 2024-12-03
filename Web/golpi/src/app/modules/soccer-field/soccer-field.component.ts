import { Component } from '@angular/core';
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-soccer-field',
  standalone: true,
  imports: [CardComponent, MatIconModule, CommonModule],
  templateUrl: './soccer-field.component.html',
  styleUrl: './soccer-field.component.css',
})
export class SoccerFieldComponent {
  public RegistrarActivo: boolean = true;
  public nombrePestana: string = 'Registrar canchas';

  activarPestana(pestana: string): void {
    if (pestana === 'registrar') {
      this.nombrePestana = 'Registrar canchas';
    }
  }
}

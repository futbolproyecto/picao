import { Component } from '@angular/core';
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { MatIconModule } from '@angular/material/icon';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-agenda',
  standalone: true,
  imports: [CardComponent, MatIconModule, CommonModule],
  templateUrl: './agenda.component.html',
  styleUrl: './agenda.component.css',
})
export class AgendaComponent {
  public AdministrarActivo: boolean = true;
  public nombrePestana: string = 'Administrar agenda';

  activarPestana(pestana: string): void {
    if (pestana === 'registrar') {
      this.nombrePestana = 'Administrar agenda';
    }
  }
}

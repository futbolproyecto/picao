import { Component } from '@angular/core';
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';

@Component({
  selector: 'app-matches',
  standalone: true,
  imports: [CardComponent, MatIconModule, CommonModule],
  templateUrl: './matches.component.html',
  styleUrl: './matches.component.css',
})
export class MatchesComponent {
  public OrganizarActivo: boolean = true;
  public nombrePestana: string = 'Organizar partido';

  activarPestana(pestana: string): void {
    if (pestana === 'organizar') {
      this.nombrePestana = 'Organizar partido';
    }
  }
}

import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogModule } from '@angular/material/dialog';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-reserva-modal',
  standalone: true,
  imports: [CommonModule, MatDialogModule],
  templateUrl: './reserva-modal.component.html',
  styleUrls: ['./reserva-modal.component.css'],
})
export class ReservaModalComponent {
  constructor(@Inject(MAT_DIALOG_DATA) public data: any) {}
}

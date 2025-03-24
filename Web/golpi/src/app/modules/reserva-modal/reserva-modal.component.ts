// Core
import { Component, Inject } from '@angular/core';
import { CommonModule } from '@angular/common';

// Librerias
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';

@Component({
  selector: 'app-reserva-modal',
  standalone: true,
  imports: [CommonModule, MatDialogModule],
  templateUrl: './reserva-modal.component.html',
  styleUrls: ['./reserva-modal.component.css'],
})
export class ReservaModalComponent {
  constructor(
    public dialogRef: MatDialogRef<ReservaModalComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any
  ) {}

  close() {
    this.dialogRef.close();
  }
}

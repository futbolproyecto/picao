// Core
import { Component, inject, Inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';

// Librerias
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { NgSelectModule } from '@ng-select/ng-select';
import {
  AbstractControl,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
} from '@angular/forms';
import { AlertsService } from '../../../core/service/alerts.service';

@Component({
  selector: 'app-reserva-modal',
  standalone: true,
  imports: [CommonModule, MatDialogModule, NgSelectModule, ReactiveFormsModule],
  templateUrl: './reserva-modal.component.html',
  styleUrls: ['./reserva-modal.component.css'],
})
export class ReservaModalComponent implements OnInit {
  public formularioInformacion: UntypedFormGroup = new UntypedFormGroup({});
  private formBuilder = inject(UntypedFormBuilder);
  private alertsService = inject(AlertsService);

  constructor(
    public dialogRef: MatDialogRef<ReservaModalComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any
  ) {
    console.log(data);
    this.buildForm();
  }

  ngOnInit(): void {
    this.formularioInformacion.get('estado')?.setValue(0);
  }

  buildForm(): void {
    this.formularioInformacion = this.formBuilder.group({
      estado: [],
    });
  }

  get estado(): AbstractControl {
    return this.formularioInformacion.get('estado')!;
  }

  cerrar() {
    this.dialogRef.close();
  }

  cambiarEstado() {
    if (this.formularioInformacion.valid) {
      if (this.estado.value == 0) {
        this.alertsService.toast('error', 'Debes seleccionar un estado');
        return;
      }
    }
  }
}

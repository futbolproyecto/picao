// Core
import { Component, inject, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import {
  AbstractControl,
  FormControl,
  FormsModule,
  ReactiveFormsModule,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { map, Observable, startWith } from 'rxjs';

// Librerias
import { MatInputModule } from '@angular/material/input';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import { MatIconModule } from '@angular/material/icon';
import { NgSelectModule } from '@ng-select/ng-select';
import { MatDialog } from '@angular/material/dialog';

// Servicios
import { AlertsService } from '../../core/service/alerts.service';

// Compatidos
import { Constant } from '../../shared/utils/constant';
import { CardComponent } from '../../shared/components/custom/card/card.component';
import { DataTableComponent } from '../../shared/components/custom/data-table/data-table.component';

// Componentes
import { ShiftsComponent } from '../shifts/shifts.component';

@Component({
  selector: 'app-agenda',
  standalone: true,
  imports: [
    CardComponent,
    MatIconModule,
    CommonModule,
    MatInputModule,
    ReactiveFormsModule,
    FormsModule,
    MatDatepickerModule,
    MatNativeDateModule,
    DataTableComponent,
    NgSelectModule,
  ],
  templateUrl: './agenda.component.html',
  styleUrl: './agenda.component.css',
})
export class AgendaComponent implements OnInit {
  private formBuilder = inject(UntypedFormBuilder);
  public formularioAgenda: UntypedFormGroup = new UntypedFormGroup({});
  private alertsService = inject(AlertsService);

  public AdministrarActivo: boolean = true;
  public nombrePestana: string = 'Administrar turno';
  public establecimientoError: string = '';
  public fechaReservaError: string = '';
  public submitted = false;

  public confirm: boolean = true;
  public finish: boolean = true;
  public edit: boolean = true;

  myControl = new FormControl('');
  options: string[] = ['One', 'Two', 'Three'];
  filteredOptions: Observable<string[]> = new Observable<string[]>();

  ngOnInit() {
    this.filteredOptions = this.myControl.valueChanges.pipe(
      startWith(''),
      map((value) => this._filter(value || ''))
    );
  }

  private _filter(value: string): string[] {
    const filterValue = value.toLowerCase();

    return this.options.filter((option) =>
      option.toLowerCase().includes(filterValue)
    );
  }

  public encabezadosAgenda = {
    id: 'ID',
    fecha: 'fecha',
    hora_inicio: 'Hora inicio',
    hora_fin: 'Hora fin',
    cancha: 'Cancha',
    cliente: 'Cliente',
    estado: 'Estado',
    acciones: 'Acciones',
  };

  tablaAgenda = [
    {
      id: '1',
      fecha: '2024-12-19',
      hora_inicio: '13:00',
      hora_fin: '14:00',
      cancha: '1',
      cliente: 'Andrea Isaza',
      estado: 'Pendiente',
    },
    {
      id: '1',
      fecha: '2024-12-19',
      hora_inicio: '14:00',
      hora_fin: '15:00',
      cancha: '2',
      cliente: 'Alejandro Mira',
      estado: 'Confirmado',
    },
  ];

  constructor(private dialog: MatDialog) {
    this.buildForm();
  }

  buildForm(): void {
    this.formularioAgenda = this.formBuilder.group({
      establecimiento: [null, [Validators.required]],
      fecha_reserva: ['', [Validators.required]],
    });
  }

  get establecimiento(): AbstractControl {
    return this.formularioAgenda.get('establecimiento')!;
  }

  get fecha_reserva(): AbstractControl {
    return this.formularioAgenda.get('fecha_reserva')!;
  }

  activarPestana(pestana: string): void {
    if (pestana === 'administrar') {
      this.nombrePestana = 'Administrar turno';
      this.AdministrarActivo = true;
    }
  }

  validarEstablecimiento(): boolean {
    let status = false;
    if (this.submitted && this.establecimiento.invalid) {
      this.establecimientoError = Constant.ERROR_CAMPO_REQUERIDO;
      status = true;
    }
    return status;
  }

  validarFechaReserva(): boolean {
    let status = false;
    if (this.submitted && this.fecha_reserva.invalid) {
      this.fechaReservaError = Constant.ERROR_CAMPO_REQUERIDO;
      status = true;
    }
    return status;
  }

  limpiarFormulario(): void {
    this.formularioAgenda.reset();
  }

  openDialog(): void {
    this.dialog.open(ShiftsComponent, {
      width: '800px',
      height: '60%',
    });
    this.limpiarFormulario();
  }

  onSubmit(): void {
    this.submitted = true;

    if (this.formularioAgenda.valid) {
      console.log('Formulario enviado con éxito');
      this.limpiarFormulario();
    } else {
      this.formularioAgenda.markAllAsTouched();
      this.alertsService.toast('error', Constant.ERROR_FORM_INCOMPLETO);
    }
  }
}

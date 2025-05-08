import { Component, Input, OnChanges, Output, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EventEmitter } from '@angular/core';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { MatTableModule } from '@angular/material/table';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatTableDataSource } from '@angular/material/table';
import { ChangeDetectorRef } from '@angular/core';
import { MatTooltipModule } from '@angular/material/tooltip';

@Component({
  selector: 'app-data-table',
  standalone: true,
  imports: [
    CommonModule,
    MatPaginatorModule,
    MatFormFieldModule,
    MatTableModule,
    MatSortModule,
    MatInputModule,
    MatTooltipModule,
  ],
  templateUrl: './data-table.component.html',
  styleUrls: ['./data-table.component.css'],
})
export class DataTableComponent implements OnChanges {
  @Input() tableData: any = [];
  @Input() titulo: string = '';
  @Input() columnHeader: any;
  @Input() edit: boolean = false;
  @Input() estado: boolean = false;
  @Input() confirm: boolean = false;
  @Input() finish: boolean = false;
  @Input() delete: boolean = false;
  @Input() visualizarInfo: boolean = false; //Visualizar informacion completa del cliente

  @Output() id: EventEmitter<number> = new EventEmitter<number>();
  @Output() item: EventEmitter<number> = new EventEmitter<number>();
  @Output() idCliente: EventEmitter<number>;

  objectKeys = Object.keys;

  dataSource = new MatTableDataSource<any>();

  @ViewChild(MatSort, { static: false }) sort!: MatSort;
  @ViewChild(MatPaginator, { static: false }) paginator!: MatPaginator;

  constructor() {
    this.id = new EventEmitter();
    this.item = new EventEmitter();
    this.idCliente = new EventEmitter();
  }

  ngOnChanges(): void {
    if (this.tableData && this.tableData.length > 0) {
      this.dataSource.data = this.tableData;
      this.dataSource.paginator = this.paginator;
      this.dataSource.sort = this.sort;
    } else {
      this.dataSource.data = [];
    }
  }

  filtrarBusqueda(event: Event) {
    const inputValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = inputValue.trim().toLowerCase();
  }

  editar(id: number) {
    this.item.emit(id);
  }

  confirmar(id: number) {
    this.item.emit(id);
  }

  finalizar(id: number) {
    this.item.emit(id);
  }

  deleteId(id: number) {
    this.item.emit(id);
  }

  actualizarEstado(i: number) {
    this.id.emit(i);
  }

  visualizar(id: number) {
    this.idCliente.emit(id);
  }
}

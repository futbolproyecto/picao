// Core
import { Component, Input, OnChanges, Output, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EventEmitter } from '@angular/core';

// Librerias
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { MatTableModule } from '@angular/material/table';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatTableDataSource } from '@angular/material/table';

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
  ],
  templateUrl: './data-table.component.html',
  styleUrl: './data-table.component.css',
})
export class DataTableComponent implements OnChanges {
  @Input() tableData: any = [];
  @Input() columnHeader: any;
  @Input() edit: boolean = false;
  @Input() estado: boolean = false;
  @Input() confirm: boolean = false;
  @Input() finish: boolean = false;

  @Output() id: EventEmitter<{ value: number }> = new EventEmitter<{
    value: number;
  }>();
  @Output() item: EventEmitter<{ value: number }> = new EventEmitter<{
    value: number;
  }>();

  objectKeys = Object.keys;

  dataSource = new MatTableDataSource<any>();

  @ViewChild(MatSort, { static: false }) sort!: MatSort;
  @ViewChild(MatPaginator, { static: false }) paginator!: MatPaginator;

  ngOnChanges(): void {
    if (this.tableData) {
      this.dataSource.data = this.tableData;
      this.dataSource.paginator = this.paginator;
      this.dataSource.sort = this.sort;
    }
  }

  constructor() {
    this.id = new EventEmitter<{ value: number }>();
    this.item = new EventEmitter<{ value: number }>();
  }

  filtrarBusqueda(event: Event) {
    const inputValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = inputValue.trim().toLowerCase();
  }

  editar(id: number) {
    this.item.emit({ value: id });
  }

  confirmar(id: number) {
    this.item.emit({ value: id });
  }

  finalizar(id: number) {
    this.item.emit({ value: id });
  }

  actualizarEstado(i: number) {
    this.id.emit({ value: i });
  }
}

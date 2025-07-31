import { Component, Input, OnChanges, Output, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EventEmitter } from '@angular/core';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { MatTableModule } from '@angular/material/table';
import { MatSort, MatSortModule } from '@angular/material/sort';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatTableDataSource } from '@angular/material/table';
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
  @Input() delete: boolean = false;

  @Output() id: EventEmitter<string> = new EventEmitter<string>();
  @Output() item: EventEmitter<any> = new EventEmitter<any>();

  objectKeys = Object.keys;

  dataSource = new MatTableDataSource<any>();

  @ViewChild(MatSort, { static: false }) sort!: MatSort;
  @ViewChild(MatPaginator, { static: false }) paginator!: MatPaginator;

  constructor() {
    this.id = new EventEmitter();
    this.item = new EventEmitter();
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

  editar(element: any) {
    this.item.emit(element);
  }

  deleteId(id: string) {
    this.id.emit(id);
  }
}

import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CardComponent } from '../../shared/components/custom/card/card.component';

import {
  ApexAxisChartSeries,
  ApexChart,
  ApexXAxis,
  ChartType,
  NgApexchartsModule,
} from 'ng-apexcharts';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, NgApexchartsModule, CardComponent],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent {
  public nombrePestana: string = 'Administrar reservaciones';
  chartSeries: ApexAxisChartSeries = [
    {
      name: 'Ventas',
      data: [100, 200, 150, 300, 250],
    },
  ];

  chartDetails: ApexChart = {
    type: 'line' as ChartType,
    height: 350,
  };

  chartXAxis: ApexXAxis = {
    categories: ['Ene', 'Feb', 'Mar', 'Abr', 'May'],
  };

  constructor() {}

  sparklineSeries = [
    {
      name: 'Ingresos',
      data: [10, 15, 14, 18, 20, 17, 22],
    },
  ];

  sparklineChart = {
    type: 'area' as ChartType,
    height: 100,
    sparkline: {
      enabled: true,
    },
  };

  sparklineStroke = {
    curve: 'smooth' as 'smooth',
    width: 2,
  };

  sparklineFill = {
    type: 'gradient',
    gradient: {
      shadeIntensity: 1,
      opacityFrom: 0.4,
      opacityTo: 0.1,
    },
  };

  sparklineTooltip = {
    enabled: false,
  };

  // Segundo grafico
  pieSeries = [44, 55, 13, 43, 22];

  pieLabels = ['Apple', 'Banana', 'Orange', 'Grape', 'Others'];

  pieChart = {
    type: 'pie' as ChartType,
    width: 400,
    height: 400,
  };

  //Tercer grafico
  barSeries = [
    {
      data: [400, 430, 448, 470, 540, 580],
    },
  ];

  barChart = {
    type: 'bar' as ChartType,
    height: 350,
  };

  barXAxis = {
    categories: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
  };

  barPlotOptions = {
    bar: {
      horizontal: true,
    },
  };

  //Cuarto grafico
  multiLineSeries = [
    { name: 'Ventas', data: [30, 40, 45, 50, 49, 60, 70] },
    { name: 'Gastos', data: [20, 29, 37, 36, 44, 45, 50] },
  ];

  multiLineChart = {
    type: 'line' as ChartType,
    height: 300,
  };

  multiLineXAxis = {
    categories: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul'],
  };
}

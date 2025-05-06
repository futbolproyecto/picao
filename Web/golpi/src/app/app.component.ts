import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NgxSpinnerModule, NgxSpinnerService } from 'ngx-spinner';
import { LoadingService } from './core/service/loading.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NgxSpinnerModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css',
})
export class AppComponent {
  title = 'Golpi';

  constructor(
    private spinner: NgxSpinnerService,
    private loadingService: LoadingService
  ) {}

  ngOnInit() {
    this.loadingService.loading$.subscribe((isLoading: boolean) => {
      if (isLoading) {
        this.spinner.show;
      } else {
        this.spinner.hide;
      }
    });
  }
}

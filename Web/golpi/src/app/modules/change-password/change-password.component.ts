import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';

@Component({
  selector: 'app-change-password',
  standalone: true,
  imports: [CommonModule, MatInputModule, MatIconModule],
  templateUrl: './change-password.component.html',
  styleUrl: './change-password.component.css',
})
export class ChangePasswordComponent {
  public passVisible: boolean = true;

  passVisibleToogle(): void {
    this.passVisible = !this.passVisible;
  }
}

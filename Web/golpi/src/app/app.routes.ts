import { Routes } from '@angular/router';
import { LoginComponent } from './modules/auth/login/login.component';

export const routes: Routes = [
  { path: '', component: LoginComponent },
  { path: '**', redirectTo: '' },
];

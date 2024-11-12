import { Routes } from '@angular/router';
import { LoginComponent } from './modules/auth/login/login.component';
import { HomeComponent } from './modules/home/home.component';
import { RegistroComponent } from './modules/registro/registro.component';
import { autenticacionGuard } from './core/guard/autenticacion.guard';
import { noAutenticacion } from './core/guard/no-autenticacion.guard';

export const routes: Routes = [
  {
    path: 'login',
    component: LoginComponent,
    // canActivate: [noAutenticacion],
  },
  {
    path: 'contactenos',
    component: RegistroComponent,
  },
  {
    path: 'home',
    component: HomeComponent,
    // canMatch: [autenticacionGuard],
  },
  {
    path: '**',
    redirectTo: '/login',
    pathMatch: 'full',
  },
];

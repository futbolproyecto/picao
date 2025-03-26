import { Routes } from '@angular/router';
import { LoginComponent } from './modules/auth/login/login.component';
import { HomeComponent } from './modules/home/home.component';
import { RegistreComponent } from './modules/registre/registre.component';
import { autenticacionGuard } from './core/guard/autenticacion.guard';
import { noAutenticacion } from './core/guard/no-autenticacion.guard';
import { UpdateDataComponent } from './modules/update-data/update-data.component';
import { SoccerFieldComponent } from './modules/soccer-field/soccer-field.component';
import { DashboardComponent } from './modules/dashboard/dashboard.component';
import { ReservationComponent } from './modules/reservation/reservation.component';
import { NotificationsComponent } from './modules/notifications/notifications.component';

export const routes: Routes = [
  {
    path: 'login',
    component: LoginComponent,
    canActivate: [noAutenticacion],
  },
  {
    path: 'contactenos',
    component: RegistreComponent,
  },
  {
    path: 'home',
    component: HomeComponent,
    canMatch: [autenticacionGuard],
    children: [
      {
        path: 'dashboard',
        title: 'Dashboard',
        component: DashboardComponent,
      },
      {
        path: 'reservacion',
        title: 'Reservación',
        component: ReservationComponent,
      },
      {
        path: 'soccer-field',
        title: 'Establecimiento',
        component: SoccerFieldComponent,
      },
      {
        path: 'update-data',
        title: 'Usuario',
        component: UpdateDataComponent,
      },
      {
        path: 'notification',
        title: 'Notificaciones',
        component: NotificationsComponent,
      },
      {
        path: '',
        redirectTo: 'dashboard',
        pathMatch: 'full',
      },
    ],
  },
  {
    path: '**',
    redirectTo: '/login',
    pathMatch: 'full',
  },
];

import { Routes } from '@angular/router';

import { HomeComponent } from './modules/home/home.component';
import { RegistreComponent } from './modules/registre/registre.component';
import { autenticacionGuard } from './core/guard/autenticacion.guard';
import { noAutenticacion } from './core/guard/no-autenticacion.guard';
import { UpdateDataComponent } from './modules/update-data/update-data.component';
import { SoccerFieldComponent } from './modules/soccer-field/soccer-field.component';
import { DashboardComponent } from './modules/dashboard/dashboard.component';
import { ReservationComponent } from './modules/reservation/reservation.component';
import { NotificationsComponent } from './modules/notifications/notifications.component';
import { ScheduleSettingsComponent } from './modules/settings/schedule-settings/schedule-settings.component';
import { UserComponent } from './modules/settings/user/user.component';
import { ChangePasswordComponent } from './modules/change-password/change-password.component';
import { LoginComponent } from './modules/login/login.component';

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
        path: 'change-password',
        title: 'Cambio contraseña',
        component: ChangePasswordComponent,
      },
      {
        path: 'notification',
        title: 'Notificaciones',
        component: NotificationsComponent,
      },
      {
        path: 'settings',
        title: 'Configuraciones',
        children: [
          {
            path: 'user',
            title: 'Usuario',
            component: UserComponent,
          },
          {
            path: 'schedule-settings',
            title: 'Bloqueo de Horarios',
            component: ScheduleSettingsComponent,
          },
          {
            path: '',
            redirectTo: 'usuario',
            pathMatch: 'full',
          },
        ],
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

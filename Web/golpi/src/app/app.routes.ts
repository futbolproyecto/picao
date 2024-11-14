import { Routes } from '@angular/router';
import { LoginComponent } from './modules/auth/login/login.component';
import { HomeComponent } from './modules/home/home.component';
import { RegistreComponent } from './modules/registre/registre.component';
import { autenticacionGuard } from './core/guard/autenticacion.guard';
import { noAutenticacion } from './core/guard/no-autenticacion.guard';
import { AgendaComponent } from './modules/agenda/agenda.component';
import { ChangePasswordComponent } from './modules/change-password/change-password.component';
import { MatchesComponent } from './modules/matches/matches.component';
import { UpdateDataComponent } from './modules/update-data/update-data.component';
import { SoccerFieldComponent } from './modules/soccer-field/soccer-field.component';

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
        path: 'agenda',
        title: 'Crear agenda',
        component: AgendaComponent,
      },
      {
        path: 'soccer-field',
        title: 'Registrar cancha',
        component: SoccerFieldComponent,
      },
      {
        path: 'change-password',
        title: 'Cambio contraseña',
        component: ChangePasswordComponent,
      },
      {
        path: 'matches',
        title: 'Organizar partidos',
        component: MatchesComponent,
      },
      {
        path: 'update-data',
        title: 'Actualizar datos',
        component: UpdateDataComponent,
      },
    ],
  },
  {
    path: '**',
    redirectTo: '/login',
    pathMatch: 'full',
  },
];

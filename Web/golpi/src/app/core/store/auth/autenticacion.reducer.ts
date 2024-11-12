// Data
import { AuthRequestDto } from '../../../data/schema/authRequestDto';

// Librerias
import { createReducer, on } from '@ngrx/store';

// Store
import { initialState } from './autenticacion.state';
import * as AutenticacionActions from './autenticacion.actions';

export const autenticacionReducer = createReducer(
  initialState,
  on(AutenticacionActions.adicionarSesion, (state, { usuarioSesion }) => ({
    ...state,
    sesion: usuarioSesion,
  })),
  on(AutenticacionActions.eliminarSesion, state => ({
    ...state,
    sesion: {} as AuthRequestDto,
  }))
);

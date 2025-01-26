import { createAction, props } from '@ngrx/store';
import { AuthRequestDto } from '../../../data/schema/authRequestDto';

// Accion para agregar la sesion del usuario al store
export const adicionarSesion = createAction(
  '[Autenticacion] Adicionar Sesion',
  props<{ usuarioSesion: AuthRequestDto }>()
);

// Accion para agregar la sesion del usuario al store
export const eliminarSesion = createAction('[Autenticacion] Eliminar Sesion');

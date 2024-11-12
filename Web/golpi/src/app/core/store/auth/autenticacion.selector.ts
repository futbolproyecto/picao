import { createFeatureSelector, createSelector } from '@ngrx/store';
import { AutenticacionState } from './autenticacion.state';

export const autenticacionKey = 'estado';
export const selectAutenticacion =
  createFeatureSelector<AutenticacionState>(autenticacionKey);

export const selectTokenSesion = createSelector(
  selectAutenticacion,
  (state) => state?.sesion?.token ?? ''

)

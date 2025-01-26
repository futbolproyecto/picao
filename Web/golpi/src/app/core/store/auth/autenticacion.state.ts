// Data

import { AuthRequestDto } from '../../../data/schema/authRequestDto';

export interface AutenticacionState {
  sesion: AuthRequestDto;
}

export const initialState: AutenticacionState = {
  sesion: {} as AuthRequestDto,
};

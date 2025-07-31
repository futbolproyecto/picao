// Dto
import { DepartamentResponseDto } from './departamentResponseDTO';

export class CityDto {
  id?: number;
  name?: string;
  department?: DepartamentResponseDto;

  constructor(init?: Partial<CityDto>) {
    if (init) {
      Object.assign(this, init);
    }
  }
}

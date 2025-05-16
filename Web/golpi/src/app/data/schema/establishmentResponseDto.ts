// Dto
import { GenericDto } from '../../core/models/generic-dto';
import { CityDto } from './cityDto';
import { DepartamentResponseDto } from './departamentResponseDTO';
import { FieldRequestDto } from './fieldRequestDTO';
import { UserResponseDto } from './userResponseDto';

export class EstablishmentResponseDto extends GenericDto {
  id?: number;
  name?: string;
  address?: string;
  mobile_number?: string;
  city?: CityDto;
  department?: DepartamentResponseDto;
  users?: UserResponseDto[];
  fields?: FieldRequestDto[];

  constructor(init?: Partial<EstablishmentResponseDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

// Dto
import { GenericDto } from '../../core/models/generic-dto';
import { CityDto } from './cityDto';

export class EstablishmentRequestDto extends GenericDto {
  id?: number;
  name?: string;
  address?: string;
  mobile_number?: string;
  city?: CityDto;
  city_id?: number;

  constructor(init?: Partial<EstablishmentRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

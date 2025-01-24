import { GenericDto } from '../../core/models/generic-dto';
import { City } from './interfaces/city';

export class DepartamentResponseDto extends GenericDto {
  id?: number;
  name?: string;
  cities?: City[];

  constructor(init?: Partial<DepartamentResponseDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

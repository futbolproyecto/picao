// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class AgendaDto extends GenericDto {
  startTime?: string;
  endTime?: string;
  cityName?: string;
  fecha?: string;
  establishmentName?: string;
  establishment?: string;

  constructor(init?: Partial<AgendaDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

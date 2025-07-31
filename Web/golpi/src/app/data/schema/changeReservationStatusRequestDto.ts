// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class ChangeReservationStatusRequestDto extends GenericDto {
  agenda_id?: string;
  agenda_status?: string;

  constructor(init?: Partial<ChangeReservationStatusRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

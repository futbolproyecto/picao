// Dto
import { GenericDto } from '../../core/models/generic-dto';
import { LockDownDayDto } from './lockDownDayDto';

export class CreateAgendaRequestDto extends GenericDto {
  field_id?: number;
  lock_down_day?: LockDownDayDto[];

  constructor(init?: Partial<CreateAgendaRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

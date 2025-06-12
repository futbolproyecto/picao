// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class ScheduleRequestDto extends GenericDto {
  field_id?: number;
  day?: Date;
  information_schedule?: Array<{
    start_time?: number;
    end_time?: number;
    fee?: number;
  }>;

  constructor(init?: Partial<ScheduleRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

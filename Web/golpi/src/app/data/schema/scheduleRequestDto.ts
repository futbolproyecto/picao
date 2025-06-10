// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class ScheduleRequestDto extends GenericDto {
  field_id?: number;
  start_time?: number;
  end_time?: number;
  fee?: number;
  day?: Date;

  constructor(init?: Partial<ScheduleRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

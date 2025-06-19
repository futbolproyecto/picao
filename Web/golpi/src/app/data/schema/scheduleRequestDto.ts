import { GenericDto } from '../../core/models/generic-dto';

export class ScheduleRequestDto extends GenericDto {
  field_ids?: number[];
  start_date?: string;
  end_date?: string;
  rule?: string;
  information_schedules?: Array<{
    start_time?: string;
    end_time?: string;
    fee?: number;
  }>;

  constructor(init?: Partial<ScheduleRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class LockDownDayDto extends GenericDto {
  day?: Date;
  start_time?: number;
  end_time?: number;

  constructor(init?: Partial<LockDownDayDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

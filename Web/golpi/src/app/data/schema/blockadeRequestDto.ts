// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class BlockadeRequestDto extends GenericDto {
  field_id?: number;
  start_time?: number;
  end_time?: number;
  days?: Date[];
  day?: Date;

  constructor(init?: Partial<BlockadeRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

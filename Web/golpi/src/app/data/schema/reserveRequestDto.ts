import { GenericDto } from '../../core/models/generic-dto';

export class ReserveRequestDto extends GenericDto {
  agenda_id?: string[];
  otp?: string;

  constructor(init?: Partial<ReserveRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

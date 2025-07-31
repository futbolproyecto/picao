// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class FieldRequestDto extends GenericDto {
  establishment_id?: string | undefined;
  name?: string;
  capacity?: number;
  is_available?: boolean;
  is_roofed?: boolean;

  constructor(init?: Partial<FieldRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

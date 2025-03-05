// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class LoginRequestDto extends GenericDto {
  email_or_mobile_number?: string;
  password?: string;

  constructor(init?: Partial<LoginRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

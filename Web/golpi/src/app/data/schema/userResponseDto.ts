// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class UserResponseDto extends GenericDto {
  id?: number;
  name?: string;
  second_name?: string;
  last_name?: string;
  second_last_name?: string;
  mobile_number?: string;
  email?: string;
  username?: string;
  date_of_birth?: string | undefined;

  constructor(init?: Partial<UserResponseDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

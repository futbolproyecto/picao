import { GenericDto } from '../../core/models/generic-dto';

export class UsuarioResponseDto extends GenericDto {
  id?: number;
  name?: string;
  second_name?: string;
  lastName?: string;
  second_last_name?: string;
  mobileNumber?: string;
  email?: string;
  dateOfBirth?: string;

  constructor(init?: Partial<UsuarioResponseDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

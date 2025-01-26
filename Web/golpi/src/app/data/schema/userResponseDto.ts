import { GenericDto } from '../../core/models/generic-dto';

export class UsuarioResponseDto extends GenericDto {
  id?: number;
  name?: string;
  secondName?: string;
  lastName?: string;
  secondLastName?: string;
  mobileNumber?: string;
  email?: string;
  username?: string;
  dateOfBirth?: string;

  constructor(init?: Partial<UsuarioResponseDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

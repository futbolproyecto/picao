import { GenericDto } from '../../core/models/generic-dto';

export class SetPasswordDto extends GenericDto {
  id_user?: number;
  old_password?: string;
  new_password?: string;

  constructor(init?: Partial<SetPasswordDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

// Dto
import { GenericDto } from '../../core/models/generic-dto';
import { BlockadeRequestDto } from './blockadeRequestDto';

export class UpdateBlockadeRequestDto extends GenericDto {
  id?: number;
  blockades?: BlockadeRequestDto[];

  constructor(init?: Partial<UpdateBlockadeRequestDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

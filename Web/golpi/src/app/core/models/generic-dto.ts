export class GenericDto<T = any> {
  status?: number;
  payload?: T;

  constructor(init?: Partial<GenericDto>) {
    if (init) {
      Object.assign(this, init);
    }
  }
}

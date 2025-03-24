export class CountryDto {
  id?: number;
  name?: string;
  cellPrefix?: String;

  constructor(init?: Partial<CountryDto>) {
    if (init) {
      Object.assign(this, init);
    }
  }
}

export class DatosTablaHorariosDto {
  id?: number;
  name?: string;
  fields?: string;
  fecha?: string;
  hora?: string;
  diasSemana?: string;

  constructor(init?: Partial<DatosTablaHorariosDto>) {
    if (init) {
      Object.assign(this, init);
    }
  }
}

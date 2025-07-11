// Dto
import { GenericDto } from '../../core/models/generic-dto';

export class InformacionReservaDto extends GenericDto {
  id?: string;
  nombreEstablecimiento?: string;
  direccion?: string;
  tipoCancha?: string;
  horarioDisponible?: string;
  precioPorHora?: number;

  constructor(init?: Partial<InformacionReservaDto>) {
    super();
    if (init) {
      Object.assign(this, init);
    }
  }
}

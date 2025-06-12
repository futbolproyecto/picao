import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';
import { EstablishmentRequestDto } from '../../data/schema/establishmentRequestDto';
import { map, Observable } from 'rxjs';
import { EventoCalendario } from '../../data/schema/interfaces/EventoCalendario';

@Injectable({
  providedIn: 'root',
})
export class ScheduleService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  crearHorario(establishmentRequestDto: EstablishmentRequestDto[]) {
    return this.http.post<GenericDto>(
      this.baseUrl + `schedules/create`,
      establishmentRequestDto
    );
  }

  obtenerEventosPorEstablecimiento(
    establishment_id: string
  ): Observable<EventoCalendario[]> {
    return this.http.get<EventoCalendario[]>(
      this.baseUrl + `schedules/by-user/${establishment_id}`
    );
  }
}

import { inject, Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';
import { ScheduleRequestDto } from '../../data/schema/scheduleRequestDto';
import { AgendaDto } from '../../data/schema/agendaDto';
import { ReserveRequestDto } from '../../data/schema/reserveRequestDto';
import { ChangeReservationStatusRequestDto } from '../../data/schema/changeReservationStatusRequestDto';

@Injectable({
  providedIn: 'root',
})
export class AgendaService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  crearAgenda(scheduleRequestDto: ScheduleRequestDto) {
    return this.http.post<GenericDto>(
      this.baseUrl + `agenda/create`,
      scheduleRequestDto
    );
  }

  cargarDisponibilidad(establishmentId: string) {
    return this.http.get<GenericDto>(
      this.baseUrl + `agenda/get-by-establishment-id/${establishmentId}`
    );
  }

  buscarDisponibilidad(agendaDto: AgendaDto) {
    let params = new HttpParams().set('city-name', agendaDto.cityName || '');

    if (agendaDto.fecha) {
      params = params.set('date', agendaDto.fecha);
    }
    if (agendaDto.startTime) {
      params = params.set('start-time', agendaDto.startTime);
    }
    if (agendaDto.endTime) {
      params = params.set('end-time', agendaDto.endTime);
    }
    if (agendaDto.establishmentName) {
      params = params.set('establishment-name', agendaDto.establishmentName);
    }

    return this.http.get<GenericDto>(
      this.baseUrl + 'agenda/get-available-by-filters',
      { params }
    );
  }

  cargarReservas(establishmentId: string) {
    return this.http.get<GenericDto>(
      this.baseUrl + `agenda/get-reserve-by-establishment-id/${establishmentId}`
    );
  }

  reservar(reserveRequestDto: ReserveRequestDto) {
    return this.http.post<GenericDto>(
      this.baseUrl + `agenda/reserve`,
      reserveRequestDto
    );
  }

  obtenerEstadosAgenda() {
    return this.http.get<GenericDto>(this.baseUrl + `agenda/agenda-status`);
  }

  cambiarEstadosAgenda(
    changeReservationStatusRequestDto: ChangeReservationStatusRequestDto
  ) {
    return this.http.put<GenericDto>(
      this.baseUrl + `agenda/change-reservation-status`,
      changeReservationStatusRequestDto
    );
  }
}

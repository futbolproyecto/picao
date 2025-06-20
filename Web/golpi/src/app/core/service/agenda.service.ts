import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';
import { ScheduleRequestDto } from '../../data/schema/scheduleRequestDto';

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
}

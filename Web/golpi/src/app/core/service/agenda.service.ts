import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';
import { CreateAgendaRequestDto } from '../../data/schema/createAgendaRequestDto';

@Injectable({
  providedIn: 'root',
})
export class AgendaService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  crearBloqueo(createAgendaRequestDto: CreateAgendaRequestDto) {
    return this.http.post<GenericDto>(
      this.baseUrl + `agenda/create`,
      createAgendaRequestDto
    );
  }
}

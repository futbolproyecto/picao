import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';
import { EstablishmentRequestDto } from '../../data/schema/establishmentRequestDto';

@Injectable({
  providedIn: 'root',
})
export class EstablishmentService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  crearEstablecimiento(establishmentRequestDto: EstablishmentRequestDto) {
    return this.http.post<GenericDto>(
      this.baseUrl + `establishment/create`,
      establishmentRequestDto
    );
  }

  establecimientoPorUsuario(userId: number) {
    return this.http.get<GenericDto>(
      this.baseUrl + `establishment/get-by-owner-user-id/${userId}`
    );
  }
}

import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';
import { FieldRequestDto } from '../../data/schema/fieldRequestDTO';

@Injectable({
  providedIn: 'root',
})
export class FieldService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  crearCancha(fieldRequestDto: FieldRequestDto) {
    return this.http.post<GenericDto>(
      this.baseUrl + `field/create`,
      fieldRequestDto
    );
  }

  canchaPorEstablecimiento(establishment_id: string) {
    return this.http.get<GenericDto>(
      this.baseUrl + `field/get-by-establishment-id/${establishment_id}`
    );
  }
}

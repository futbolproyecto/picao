import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';
import { BlockadeRequestDto } from '../../data/schema/blockadeRequestDto';
import { Router } from 'express';

@Injectable({
  providedIn: 'root',
})
export class BlockadeService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  crearBloqueo(blockadeRequestDto: BlockadeRequestDto[]) {
    return this.http.post<GenericDto>(
      this.baseUrl + `blockade/create`,
      blockadeRequestDto
    );
  }

  bloqueosPorUsuario(userId: number) {
    return this.http.get<GenericDto>(
      this.baseUrl + `blockade/get-by-user-id/${userId}`
    );
  }

  eliminarHorario(id: number) {
    return this.http.put<GenericDto>(
      this.baseUrl + `blockade/get-by-user-id/${id}`,
      ''
    );
  }
}

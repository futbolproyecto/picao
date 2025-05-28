import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';
import { BlockadeRequestDto } from '../../data/schema/blockadeRequestDto';
import { UpdateBlockadeRequestDto } from '../../data/schema/updateBlockadeRequestDto';

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

  eliminarHorario(blockadeId: string) {
    return this.http.delete<GenericDto>(
      this.baseUrl + `blockade/delete-by-id/${blockadeId}`
    );
  }

  updateHorario(updateBlockadeRequestDto: UpdateBlockadeRequestDto) {
    return this.http.put(
      this.baseUrl + 'blockade/update',
      updateBlockadeRequestDto
    );
  }

  bloqueosPorUsuarioId(blockadeId: number) {
    return this.http.get<GenericDto>(
      this.baseUrl + `blockade/get-by-id/${blockadeId}`
    );
  }
}

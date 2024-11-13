import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/enviroment';
import { UsuarioResponseDto } from '../../data/schema/userResponseDto';
import { GenericDto } from '../models/generic-dto';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  getById(id: number): Observable<GenericDto> {
    return this.http.get<GenericDto>(this.baseUrl + `/user/get-by-id/${id}`);
  }
}

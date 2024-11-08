import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { GenericDto } from '../models/generic-dto';
import { HttpClient } from '@angular/common/http';
import { UsuarioDto } from '../models/usuario-dto';
import { environment } from '../../../environments/enviroment';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  iniciarSesion(usuario: UsuarioDto): Observable<GenericDto> {
    return this.http
      .post<GenericDto>(this.baseUrl + '/authentication/login', usuario)
      .pipe();
  }
}

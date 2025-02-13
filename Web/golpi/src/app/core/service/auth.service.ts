import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { LoginRequestDto } from '../../data/schema/loginRequestDto';
import { environment } from '../../../environments/environment';
import { AuthRequestDto } from '../../data/schema/authRequestDto';
import { ConstantesEndpoints } from '../utils/models/constantes-endpoints';
import { AutenticacionStoreService } from '../store/auth/autenticacion-store.service';
import { GenericDto } from '../models/generic-dto';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private store = inject(AutenticacionStoreService);
  private http = inject(HttpClient);
  private router = inject(Router);
  baseUrl: string = environment.BaseUrl;

  iniciarSesion(loginRequestDto: LoginRequestDto): Observable<GenericDto> {
    return this.http.post<GenericDto>(
      this.baseUrl + ConstantesEndpoints.LOGIN,
      loginRequestDto
    );
  }

  verificarToken(): string {
    let token = this.store.obtenerToken$();
    return token;
  }

  cerrarSesion() {
    this.store.eliminarSesion$();
    sessionStorage.removeItem('authentication');
    sessionStorage.clear();
    this.router.navigate(['/login']);
  }
}

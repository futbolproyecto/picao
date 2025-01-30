import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';
import { OtpRequestDto } from '../../data/schema/otpRequestDto';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  getById(id: number): Observable<GenericDto> {
    return this.http.get<GenericDto>(this.baseUrl + `user/get-by-id/${id}`);
  }

  envioCodigo(otpDto: OtpRequestDto) {
    return this.http.put(this.baseUrl + `user/change-password`, otpDto);
  }

  getAll() {
    return this.http.get<GenericDto>(this.baseUrl + `user/get-all`);
  }
}

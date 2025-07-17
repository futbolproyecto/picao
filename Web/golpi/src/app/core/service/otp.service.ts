import { inject, Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { OtpRequestDto } from '../../data/schema/otpRequestDto';

@Injectable({
  providedIn: 'root',
})
export class OtpService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  envioEmail(email: OtpRequestDto) {
    const params = new HttpParams().set('email', email.email || '');
    return this.http.post(this.baseUrl + 'otp/send-email', null, { params });
  }

  validarEmail(otp: OtpRequestDto) {
    const params = new HttpParams()
      .set('email', otp.email || '')
      .set('otp', otp.otp || '');

    return this.http.post(this.baseUrl + 'otp/validate-email', null, {
      params,
    });
  }

  envioCodigoNumeroCelular(otpRequestDto: OtpRequestDto) {
    const params = new HttpParams()
      .set('mobile_number', otpRequestDto.mobile_number!)
      .set('is_reserve', otpRequestDto.is_reserve!);

    return this.http.post(this.baseUrl + 'otp/send-mobilenumber', null, {
      params: params,
    });
  }

  validarNumero(otp: OtpRequestDto) {
    const params = new HttpParams()
      .set('otp', otp.otp!)
      .set('mobile_number', otp.mobile_number!);

    return this.http.put(this.baseUrl + 'otp/validate-mobilenumber', null, {
      params,
    });
  }
}

import { inject, Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment';
import { GenericDto } from '../models/generic-dto';

@Injectable({
  providedIn: 'root',
})
export class CountryService {
  private http = inject(HttpClient);
  baseUrl: string = environment.BaseUrl;

  getAll() {
    return this.http.get<GenericDto>(this.baseUrl + `country/get-all`);
  }
}

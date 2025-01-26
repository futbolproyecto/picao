import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class ModoAuthService {
  private modoRegistroSubject = new BehaviorSubject<boolean>(false);
  esModoRegistro$ = this.modoRegistroSubject.asObservable();

  toggleModo() {
    this.modoRegistroSubject.next(!this.modoRegistroSubject.value);
  }

  setModoRegistro(modo: boolean) {
    this.modoRegistroSubject.next(modo);
  }
}

// Import angular
import { inject, Injectable } from '@angular/core';

// Import libraries
import { BehaviorSubject, map, Observable } from 'rxjs';
import { Store } from '@ngrx/store';

//Store
import { AutenticacionState } from './autenticacion.state';
import * as fromAutenticacionActions from './autenticacion.actions';
import * as fromAutenticacionSelectors from './autenticacion.selector';

// Import models
import { AuthRequestDto } from '../../../data/schema/authRequestDto';

@Injectable({
  providedIn: 'root',
})
export class AutenticacionStoreService {
  private store = inject(Store<AutenticacionState>);

  // dispatch
  public adicionarSesion(nuevaSesion: AuthRequestDto) {
    sessionStorage.setItem('authentication', JSON.stringify(nuevaSesion));

    this.store.dispatch(
      fromAutenticacionActions.adicionarSesion({
        usuarioSesion: nuevaSesion,
      })
    );
  }

  public eliminarSesion$() {
    this.store.dispatch(fromAutenticacionActions.eliminarSesion());
  }

  public obtenerToken$(): string {
    let token: string = '';
    this.store
      .select(fromAutenticacionSelectors.selectTokenSesion)
      .subscribe((data) => {
        token = data;
      });
    return token;
  }

  public obtenerSesion$(): Observable<AuthRequestDto> {
    return this.store.select(fromAutenticacionSelectors.selectSesion);
  }

  public obtenerId$(): Observable<number> {
    return this.store
      .select(fromAutenticacionSelectors.selectId)
      .pipe(map((id) => id ?? 0));
  }

  private tieneEstablecimientoSubject = new BehaviorSubject<boolean>(true);
  tieneEstablecimiento$ = this.tieneEstablecimientoSubject.asObservable();
  setTieneEstablecimiento(valor: boolean) {
    this.tieneEstablecimientoSubject.next(valor);
  }
}

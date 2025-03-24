import { ApplicationConfig, importProvidersFrom } from '@angular/core';
import { provideRouter } from '@angular/router';
import { routes } from './app.routes';
import {
  provideHttpClient,
  withFetch,
  withInterceptors,
} from '@angular/common/http';
import { provideState, provideStore } from '@ngrx/store';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { autenticacionReducer } from './core/store/auth/autenticacion.reducer';
import { AuthInterceptor } from './core/interceptors/auth.interceptor';
import { loadingInterceptor } from './core/interceptors/loading.interceptor';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgxSpinnerModule } from 'ngx-spinner';

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideHttpClient(withFetch(), withInterceptors([AuthInterceptor])),
    provideHttpClient(withInterceptors([loadingInterceptor])),
    importProvidersFrom(
      [BrowserAnimationsModule],
      NgxSpinnerModule.forRoot({ type: 'square-jelly-box' })
    ),
    provideStore(),
    provideAnimationsAsync(),
    provideState({ name: 'estado', reducer: autenticacionReducer }),
  ],
};

import {
  HttpHandlerFn,
  HttpInterceptorFn,
  HttpRequest,
} from '@angular/common/http';
import { inject } from '@angular/core';
import { AuthService } from '../service/auth.service';
import { environment } from '../../../environments/environment';

export const AuthInterceptor: HttpInterceptorFn = (
  req: HttpRequest<any>,
  next: HttpHandlerFn
) => {
  const authService = inject(AuthService);

  const isUnprotectedEndpoint = environment.UnprotectedEndpoints.some(
    (endpoint) => req.url.includes(endpoint)
  );

  if (isUnprotectedEndpoint) {
    return next(req);
  }

  const token = authService.verificarToken();
  if (!!token) {
    const cloned = req.clone({
      setHeaders: {
        Authorization: 'Bearer ' + token,
        'Content-type': 'application/json',
      },
    });
    return next(cloned);
  } else {
    return next(req);
  }
};

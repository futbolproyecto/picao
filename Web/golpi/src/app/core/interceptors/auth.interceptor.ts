import { HttpHandlerFn, HttpInterceptorFn, HttpRequest } from '@angular/common/http';
import { inject } from '@angular/core';
import { AuthService } from '../service/auth.service';

export const AuthInterceptor: HttpInterceptorFn = (
  req: HttpRequest<any>,
  next: HttpHandlerFn
) => {
  const authService = inject(AuthService);
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

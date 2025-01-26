import { inject } from '@angular/core';
import { CanMatchFn, Router } from '@angular/router';
import { AuthService } from '../service/auth.service';

export const autenticacionGuard: CanMatchFn = () => {
  const token = inject(AuthService).verificarToken();
  const router = inject(Router);
  console.log(token);
  if (token) {
    return true;
  } else {
    router.navigate(['']);
    return false;
  }
};

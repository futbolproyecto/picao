import { inject } from '@angular/core';
import { CanMatchFn, Router } from '@angular/router';
import { AuthService } from '../service/auth.service';

export const noAutenticacion: CanMatchFn = () => {
  const token = inject(AuthService).verificarToken();
  const router = inject(Router);
  if (token) {
    router.navigate(['/home']);
    return false;
  }
  return true;
};

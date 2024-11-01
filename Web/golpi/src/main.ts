import { bootstrapApplication } from '@angular/platform-browser';
import { provideRouter } from '@angular/router';
import { routes } from './app/app.routes';
import { LoginComponent } from './app/modules/auth/login/login.component';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';

bootstrapApplication(LoginComponent, {
  providers: [
    provideRouter(routes), provideAnimationsAsync() 
  ],
}).catch((err) => console.error(err));

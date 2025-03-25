import { Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { authGuard } from './auth.guard';

export const routes: Routes = [
    { 
      path: '', 
      loadChildren: () => import('./demo/demo.module').then(m => m.DemoModule),
    },
    {
      path: 'login',
      component: LoginComponent,
    },
    {
      path: '**',
      redirectTo: ''
    }
  ]

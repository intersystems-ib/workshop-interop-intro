import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { OrderCreateComponent } from './order-create/order-create.component';
import { authGuard } from '../auth.guard';

export const routes: Routes = [
  {
    path: '',
    component: OrderCreateComponent,
    canActivate: [authGuard]
  },
  {
    path: 'create-order',
    component: OrderCreateComponent,
    canActivate: [authGuard]
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DemoRoutingModule { }

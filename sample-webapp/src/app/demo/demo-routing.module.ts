import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { OrderCreateComponent } from './order-create/order-create.component';

export const routes: Routes = [
  {
    path: '',
    component: OrderCreateComponent
  },
  {
    path: 'create-order',
    component: OrderCreateComponent
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DemoRoutingModule { }

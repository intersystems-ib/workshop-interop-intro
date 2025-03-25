import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { OrderService } from '../order.service';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';
import {MatIconModule} from '@angular/material/icon';
import { FormsModule } from '@angular/forms';
import { NgIf } from '@angular/common';
import { NgFor } from '@angular/common';

@Component({
  selector: 'app-order-create',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    FormsModule,
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatProgressBarModule,
    MatSelectModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatIconModule,
    NgIf,
    NgFor
  ],
  templateUrl: './order-create.component.html',
  styleUrl: './order-create.component.scss'
})
export class OrderCreateComponent {
  orderForm: FormGroup;
  isSubmitting = false;
  successMessage = '';
  errorMessage = '';

  priceFields = [
    { label: 'Ship Mode', control: 'ShipMode', type: 'text', placeholder: 'e.g. Express Air' },
    { label: 'Quantity', control: 'Quantity', type: 'number', placeholder: 'e.g. 8' },
    { label: 'Sales', control: 'Sales', type: 'text', placeholder: 'e.g. 1446.67' },
    { label: 'Unit Price', control: 'UnitPrice', type: 'text', placeholder: 'e.g. 205.99' },
    { label: 'Discount', control: 'Discount', type: 'text', placeholder: 'e.g. 0' },
    { label: 'Shipping Cost', control: 'ShippingCost', type: 'text', placeholder: 'e.g. 2.5' }
  ];

  constructor(private fb: FormBuilder, private orderService: OrderService) {
    this.orderForm = this.fb.group({
      OrderPriority: ['Not Specified', Validators.required],
      Discount: ['0', Validators.required],
      UnitPrice: ['205.99', Validators.required],
      ShippingCost: ['2.5', Validators.required],
      CustomerID: ['3', Validators.required],
      ShipMode: ['Express Air', Validators.required],
      ProductCategory: ['Technology', Validators.required],
      ProductSubCategory: ['Telephones and Communication', Validators.required],
      ProductContainer: ['Small Box', Validators.required],
      ProductName: ['V70', Validators.required],
      OrderDate: [new Date('2011-07-27'), Validators.required],
      Quantity: ['8', Validators.required],
      Sales: ['1446.67', Validators.required],
      OrderID: ['88523', Validators.required]
    });
  }

  submitOrder() {
    if (this.orderForm.invalid) return;
    this.isSubmitting = true;
    this.successMessage = '';
    this.errorMessage = '';

    const payload = {
      ...this.orderForm.value,
      OrderDate: this.orderForm.value.OrderDate.toLocaleDateString()
    };

    this.orderService.submitOrder(payload)
      .subscribe({
        next: () => {
          this.successMessage = 'Order submitted successfully!';
          this.orderForm.reset();
        },
        error: (err) => {
          this.errorMessage = 'Error submitting order.';
          console.error(err);
        },
        complete: () => this.isSubmitting = false
      });
  }
}

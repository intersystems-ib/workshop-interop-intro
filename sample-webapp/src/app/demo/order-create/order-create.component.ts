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
  errorMessage = '';
  formVisible = true;

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
      OrderPriority: ['', Validators.required],
      Discount: ['', Validators.required],
      UnitPrice: ['', Validators.required],
      ShippingCost: ['', Validators.required],
      CustomerID: ['', Validators.required],
      ShipMode: ['', Validators.required],
      ProductCategory: ['', Validators.required],
      ProductSubCategory: ['', Validators.required],
      ProductContainer: ['', Validators.required],
      ProductName: ['', Validators.required],
      OrderDate: [null, Validators.required],
      Quantity: ['', Validators.required],
      Sales: ['', Validators.required],
      OrderID: ['', Validators.required]
    });

    this.setRandomSampleData();
  }

  setRandomSampleData() {
    const rand = (min: number, max: number) => (Math.random() * (max - min) + min).toFixed(2);
    const randomDate = new Date(2010 + Math.floor(Math.random() * 10), Math.floor(Math.random() * 12), Math.floor(Math.random() * 28) + 1);
    const sample = {
      OrderPriority: 'Medium',
      Discount: rand(0, 0.3),
      UnitPrice: rand(50, 500),
      ShippingCost: rand(1, 10),
      CustomerID: Math.floor(Math.random() * 100).toString(),
      ShipMode: 'Express Air',
      ProductCategory: 'Technology',
      ProductSubCategory: 'Gadgets',
      ProductContainer: 'Small Box',
      ProductName: 'Gizmo ' + Math.floor(Math.random() * 1000),
      OrderDate: randomDate,
      Quantity: ''+Math.floor(Math.random() * 10 + 1),
      Sales: rand(100, 2000),
      OrderID: (10000 + Math.floor(Math.random() * 90000)).toString()
    };
    this.orderForm.patchValue(sample);
  }

  submitOrder() {
    if (this.orderForm.invalid) return;
    this.isSubmitting = true;
    this.errorMessage = '';

    const payload = {
      ...this.orderForm.value,
      OrderDate: this.orderForm.value.OrderDate.toLocaleDateString()
    };

    this.orderService.submitOrder(payload)
      .subscribe({
        next: () => {
          this.formVisible = false;
        },
        error: (err) => {
          this.errorMessage = 'Error submitting order.';
          console.error(err);
        },
        complete: () => this.isSubmitting = false
      });
  }

  resetForm() {
    this.orderForm.reset();
    this.setRandomSampleData();
    this.formVisible = true;
  }
}

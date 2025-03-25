// order.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class OrderService {
  private apiUrl = 'http://localhost:52773/order/api/order';

  constructor(private http: HttpClient) {}

  submitOrder(order: any): Observable<any> {
    return this.http.post(this.apiUrl, order);
  }
}

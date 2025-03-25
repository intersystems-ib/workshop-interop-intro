// auth.interceptor.ts
import { Injectable } from '@angular/core';
import {
  HttpInterceptor,
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpErrorResponse
} from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, switchMap } from 'rxjs/operators';
import { AuthService } from './auth.service';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  private isRefreshing = false;

  private readonly protectedUrls = [
    'http://localhost:52773/order/api/order',
    'http://localhost:52773/order/api/logout',
  ];

  constructor(private authService: AuthService) {}

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const shouldIntercept = this.protectedUrls.some(url => req.url.startsWith(url));

    if (!shouldIntercept) {
      return next.handle(req); // No modificar
    }

    const token = this.authService.getToken();
    const authReq = token
      ? req.clone({ setHeaders: { Authorization: `Bearer ${token}` } })
      : req;

    return next.handle(authReq).pipe(
      catchError((error: HttpErrorResponse) => {
        if (error.status === 401 && !this.isRefreshing) {
          this.isRefreshing = true;
          return this.authService.refreshToken().pipe(
            switchMap(() => {
              this.isRefreshing = false;
              const newToken = this.authService.getToken();
              const newReq = req.clone({ setHeaders: { Authorization: `Bearer ${newToken}` } });
              return next.handle(newReq);
            }),
            catchError(err => {
              this.isRefreshing = false;
              this.authService.clearTokens();
              return throwError(() => err);
            })
          );
        }

        return throwError(() => error);
      })
    );
  }
}

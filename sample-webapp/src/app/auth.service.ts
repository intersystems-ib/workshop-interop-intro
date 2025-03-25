// auth.service.ts
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable, tap } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';
import { environment } from '../environments/environment';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private tokenKey = 'access_token';
  private refreshKey = 'refresh_token';

  private loggedIn = new BehaviorSubject<boolean>(false);
  isLoggedIn$ = this.loggedIn.asObservable();

  private currentUserSubject = new BehaviorSubject<string | null>(null);
  currentUser$ = this.currentUserSubject.asObservable();

  constructor(private http: HttpClient, private router: Router) {
    const token = this.getToken();
    if (token) {
      this.loggedIn.next(true);
      this.setCurrentUserFromToken(token);
    }
  }

  login(user: string, password: string): Observable<any> {
    return this.http.post(environment.irisUrl+'/order/api/login', { user, password }).pipe(
      tap((res: any) => {
        localStorage.setItem(this.tokenKey, res.access_token);
        localStorage.setItem(this.refreshKey, res.refresh_token);
        this.loggedIn.next(true);
        this.setCurrentUserFromToken(res.access_token);
      })
    );
  }

  logout() {
    this.http.post(environment.irisUrl+'/order/api/logout', {}).subscribe(() => {
      this.clearTokens();
      this.router.navigate(['/login']);
    });
  }

  refreshToken(): Observable<any> {
    const refresh_token = localStorage.getItem(this.refreshKey);
    return this.http.post(environment.irisUrl+'/order/api/refresh', {
      refresh_token,
      grant_type: 'refresh_token'
    }).pipe(
      tap((res: any) => {
        localStorage.setItem(this.tokenKey, res.access_token);
        this.setCurrentUserFromToken(res.access_token);
      })
    );
  }

  getToken(): string | null {
    return localStorage.getItem(this.tokenKey);
  }

  getCurrentUsername(): string | null {
    return this.currentUserSubject.value;
  }

  getIsLoggedIn(): boolean | null {
    return this.loggedIn.value;
  }

  private setCurrentUserFromToken(token: string) {
    const decoded = this.decodeToken(token);
    const sub = decoded?.sub || null;
    this.currentUserSubject.next(sub);
  }

  clearTokens() {
    localStorage.removeItem(this.tokenKey);
    localStorage.removeItem(this.refreshKey);
    this.loggedIn.next(false);
    this.currentUserSubject.next(null);
  }

  private decodeToken(token: string): any {
    try {
      const payload = token.split('.')[1];
      return JSON.parse(atob(payload));
    } catch {
      return null;
    }
  }
}

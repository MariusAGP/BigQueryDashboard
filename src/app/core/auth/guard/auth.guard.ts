import {inject, Injectable, Injector, runInInjectionContext} from '@angular/core';
import {CanActivate, Router} from '@angular/router';
import {Auth, user} from '@angular/fire/auth';
import {Observable} from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  private auth = inject(Auth);
  private router = inject(Router);
  private injector = inject(Injector);

  canActivate(): Observable<boolean> {
    return new Observable<boolean>((observer) => {
      runInInjectionContext(this.injector, () => {
        user(this.auth).subscribe((firebaseUser) => {
          if (firebaseUser) {
            observer.next(true);
          } else {
            this.router.navigate(['/login']);
            observer.next(false);
          }
          observer.complete();
        });
      });
    });
  }
}

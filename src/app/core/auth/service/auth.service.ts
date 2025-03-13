import {inject, Injectable} from '@angular/core';
import {Auth, signInWithEmailAndPassword} from '@angular/fire/auth';
import {from, Observable} from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  firebaseAuth: Auth = inject(Auth)
  login(email: string, password: string): Observable<void> {
    const promise = signInWithEmailAndPassword(
      this.firebaseAuth,
      email,
      password
    ).then(() => {});
    return from(promise);
  }
}

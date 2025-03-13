import {Component, inject} from '@angular/core';
import {MatInput, MatInputModule} from '@angular/material/input';
import {FormBuilder, ReactiveFormsModule, Validators} from '@angular/forms';
import {AuthService} from '../../service/auth.service';
import {Router} from '@angular/router';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatButton} from '@angular/material/button';

@Component({
  selector: 'app-login',
  imports: [
    MatInput,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButton
  ],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {

  formBuilder: FormBuilder = inject(FormBuilder);
  authService: AuthService = inject(AuthService);
  router: Router = inject(Router);

  errorMessage: string | null = null;
  form = this.formBuilder.nonNullable.group({
    email: ["", Validators.required],
    password: ["", Validators.required]
  });


  onSubmit(): void {
    const rawForm = this.form.getRawValue();
    this.authService
      .login(rawForm.email, rawForm.password)
      .subscribe({
        next: () => {
          this.router.navigateByUrl("/dashboard");
        },
        error: (err) => {
          this.errorMessage = err.code;
        }
      })

  }

}

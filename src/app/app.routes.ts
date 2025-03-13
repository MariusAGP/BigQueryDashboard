import { Routes } from '@angular/router';
import {DashboardComponent} from './feature/dashboard/dashboard.component';
import {LoginComponent} from './core/auth/pages/login/login.component';
import {AuthGuard} from './core/auth/guard/auth.guard';

export const routes: Routes = [
  { path: "dashboard", component: DashboardComponent, canActivate: [AuthGuard] },
  { path: "login", component: LoginComponent },
  { path: "", redirectTo: "/login", pathMatch: "full" }
];

import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { CoachesComponent } from './pages/coaches/coaches.component';
import { LoginComponent } from './pages/auth/login.component';
import { RegisterComponent } from './pages/auth/register.component';

export const routes: Routes = [
    { path: '', component: HomeComponent },
    { path: 'coaches', component: CoachesComponent },
    { path: 'login', component: LoginComponent },
    { path: 'register', component: RegisterComponent },
    { path: '**', redirectTo: '' }
];

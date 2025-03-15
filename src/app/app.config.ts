import {ApplicationConfig, provideZoneChangeDetection} from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import {getApp, initializeApp, provideFirebaseApp} from '@angular/fire/app';
import {getAuth, provideAuth} from '@angular/fire/auth';
import {getFunctions, provideFunctions} from '@angular/fire/functions';
import { provideCharts, withDefaultRegisterables } from 'ng2-charts';
import { initializeAppCheck, provideAppCheck } from '@angular/fire/app-check';
import { ReCaptchaV3Provider } from '@firebase/app-check';
import { environment } from '../environments/environment';

export const appConfig: ApplicationConfig = {
  providers: [
    provideZoneChangeDetection({ eventCoalescing: true }),
    provideRouter(routes),
    provideFirebaseApp(() => initializeApp(environment.firebaseConfig)),
    provideAuth(() => getAuth()),
    provideFunctions(() => getFunctions()),
    provideCharts(withDefaultRegisterables()),
    provideAppCheck(() => initializeAppCheck(getApp(), {
      provider: new ReCaptchaV3Provider("sdfsdffsdfds"),
      isTokenAutoRefreshEnabled: true
    }))
  ],
};

import {inject, Injectable} from '@angular/core';
import {Functions, httpsCallable} from '@angular/fire/functions';
import {from, map, Observable} from 'rxjs';
import {Sales} from '../model/sales';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {
  private functions: Functions = inject(Functions)

  callUploadToBigQuery(fileName: string): Observable<any> {
    const queryFunction = httpsCallable(
      this.functions,
      "uploadToBigQuery",
      { limitedUseAppCheckTokens: true }
    );
    return from(queryFunction( {fileName} ))
  }

  callQueryBigQuery(): Observable<Sales[]> {
    const queryFunction = httpsCallable<void, { data: Sales[] }>(
      this.functions,
      "queryBigQuery",
      { limitedUseAppCheckTokens: true }
    );

    return from(queryFunction()).pipe(
      map((response: any) => response.data)
    );
  }
}

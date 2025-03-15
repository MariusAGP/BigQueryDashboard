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
    );
    return from(queryFunction({fileName}))
  }

  callQueryBigQuery(): Observable<Sales[]> {
    const queryFunction = httpsCallable<void, { data: Sales[] }>(
      this.functions,
      "queryBigQuery",
    );

    return from(queryFunction()).pipe(
      map((response: any) => {
          return response.data.map(this.mapBigQueryRowToSales);
        }
      ));
  }

  private mapBigQueryRowToSales(row: any): Sales {
    return {
      region: row["Region"],
      country: row["Country"],
      salesChannel: row["Sales Channel"],
      orderPriority: row["Order Priority"],
      orderDate: row["Order Date"]?.value,
      orderId: row["Order ID"],
      shipDate: row["Ship Date"]?.value,
      unitsSold: row["Units Sold"],
      unitPrice: row["Unit Price"],
      unitCost: row["Unit Cost"],
      totalRevenue: row["Total Revenue"],
      totalCost: row["Total Cost"],
      totalProfit: row["Total Profit"],
    };
  }
}

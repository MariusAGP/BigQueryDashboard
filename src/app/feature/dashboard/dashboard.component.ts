import {Component, inject} from '@angular/core';
import {MatButton} from "@angular/material/button";
import {DashboardService} from './service/dashboard.service';
import {ChartData, ChartOptions} from 'chart.js';
import {Sales} from './model/sales';
import {BaseChartDirective} from 'ng2-charts';
import {MatProgressBar} from '@angular/material/progress-bar';

@Component({
  selector: 'app-dashboard',
  imports: [
    MatButton,
    BaseChartDirective,
    MatProgressBar
  ],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  private dashboardService: DashboardService = inject(DashboardService);
  pieChartLabels: string[] = [];
  pieChartData: ChartData<'pie'> = {
    labels: ["No Data"], // Empty initially
    datasets: [
      {
        data: [100], // Empty data initially
        label: 'Top 5 Countries by Profit',
        backgroundColor: ['#D3D3D3'],
      },
    ],
  };
  pieChartOptions: ChartOptions<'pie'> = {
    color: "grey",
    responsive: true,
    plugins: {
      legend: { display: true, position: 'top' },
    },
  };

  isLoading = false;
  isDataLoaded = false;
  uploadDone = false;
  errorMessage: string | null = null;

  startUploadToBigQuery(): void {
    this.isLoading = true;
    this.errorMessage = null;
    this.dashboardService.callUploadToBigQuery("sales_file.csv").subscribe({
      error: (error) => {
        console.error("Error uploading data to big query: ", error);
        this.errorMessage = error
      },
      complete: () => {
        this.isLoading = false;
        this.uploadDone = true;
      }
    })
  }

  loadChartData(): void {
    this.isLoading = true;
    this.errorMessage = null;
    this.dashboardService.callQueryBigQuery().subscribe({
      next: (salesData: Sales[]) => {
        const topCountries = this.getTopCountriesByProfit(salesData);
        this.pieChartLabels = topCountries.map((s) => s.country);
        this.pieChartData = {
          labels: this.pieChartLabels, // Assign the countries
          datasets: [
            {
              data: topCountries.map((s) => s.totalProfit), // Assign profits to data
              label: 'Total Profit',
            },
          ],
        };
        this.isDataLoaded = true;
      },
      error: (error) => {
        console.error('Error loading sales data:', error);
        this.errorMessage = error
      },
      complete: () => {
        this.isLoading = false;
      }
    });
  }

  private getTopCountriesByProfit(salesData: Sales[]): Sales[] {
    return salesData
      .reduce((acc, sale) => {
        const existing = acc.find((s) => s.country === sale.country);
        if (existing) {
          existing.totalProfit += sale.totalProfit;
        } else {
          acc.push({ ...sale });
        }
        return acc;
      }, [] as Sales[])
      .sort((a, b) => b.totalProfit - a.totalProfit)
      .slice(0, 5);
  }
}

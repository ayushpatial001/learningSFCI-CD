import { LightningElement,track } from 'lwc';
import ChartJs from '@salesforce/resourceUrl/ChartJs';
import { loadScript } from 'lightning/platformResourceLoader';
import getRemainingLeaves from '@salesforce/apex/FetchLeaveDataAccToCurrentLoginData.getRemainingLeaves';


export default class MakingChart extends LightningElement {
@track isChartJsInitialized = false;
data1 = [];
remianingBalance;
totalbalance;

connectedCallback(){
  getRemainingLeaves().then(data =>{
    console.log('this is the data in chart-->'+JSON.stringify(data));
   this.remianingBalance = Math.floor(data[0].RemainigLeaves);
   this.totalbalance = Math.floor(data[0].TotalBalance);
   console.log('this.remianingBalance  '+ this.remianingBalance);
   console.log('this.totalbalance' +  this.totalbalance);

   this.data1 = [this.remianingBalance,this.totalbalance ];

    console.log('this is the final data---> '+ this.data1);
     
     

  });
}
renderedCallback() {
  if (this.isChartJsInitialized) {
  return;
}
this.isChartJsInitialized = true;
Promise.all([
  loadScript(this, ChartJs)
])
.then(() => {
// Chart.js library loaded
  this.initializePieChart();
})
.catch(error => {
  console.log('Error loading Chart.js');
  console.error(error);
});
}
initializePieChart() {
    
    const ctx = this.template.querySelector('canvas').getContext('2d');
    new window.Chart(ctx, {
    type: 'doughnut',
    data: {
    labels: ['Available Balance','Total Balance'],
    datasets: [{
    label: '# of Votes',
    data: [this.remianingBalance,this.totalbalance],
    backgroundColor: [
    'rgba(255, 99, 132, 0.5)',
    'rgba(54, 162, 235, 0.5)',
    'rgba(255, 206, 86, 0.5)',
    'rgba(75, 192, 192, 0.5)',
    'rgba(153, 102, 255, 0.5)',
    'rgba(255, 159, 64, 0.5)'
    ] 
    }]
    },
    options: {
    responsive: true,
    maintainAspectRatio: false,
    title: {
    display: true,
    text: "Leave Information"
    }
    },
    });
    }


}
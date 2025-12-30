import { LightningElement } from 'lwc';
import getContacts from '@salesforce/apex/AllEmployeeRecordForLwc.getAllEmployeeMethod';

const columns = [
   {label:'Name',fieldName: 'Name'},
   {label:'Email',fieldName: 'Email_Address__c'},
   {label:'Phone',fieldName: 'Primary_Number__c'},
   {label:'Joining Date',fieldName: 'Joining_Date__c'},
   {label:'Date Of Birth', fieldName: 'Date_of_Birth__c'}

];



export default class AllEmployeeRecordDataTable extends LightningElement {
    data = [];
    columns =  columns;
    totalEmployeeRecord;
    
   

    connectedCallback(){
      
        getContacts().then(
            data=>{
                this.data = data;
                this.totalEmployeeRecord = data.length;
            }

        ).catch(error=>{
             console.log(error);
        })
    }
  
}
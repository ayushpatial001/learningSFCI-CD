import { LightningElement, wire, track, api } from 'lwc';
import getEmployeeList from '@salesforce/apex/EmployeeRecordForPagination.getEmployeeList';
import getNext from '@salesforce/apex/EmployeeRecordForPagination.getNext';
import getPrevious from '@salesforce/apex/EmployeeRecordForPagination.getPrevious';
import totalRecords from '@salesforce/apex/EmployeeRecordForPagination.totalRecords';
import listOfSeachableRecord from '@salesforce/apex/EmployeeRecordForPagination.listOfSeachableRecord';
import { ShowToastEvent } from  'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';





const COLS = [
    { label: 'Employee Name', fieldName: 'Name',editable: true },
    { label: 'Email', fieldName: 'Email_Address__c' },
    {label: 'Phone Number', fieldName: 'Primary_Number__c'},
    {label: 'Joining Date', fieldName:'Joining_Date__c'},
    {type: 'action',
        typeAttributes: {
            rowActions: [
                {label: 'Edit', name: 'edit'},
                {label: 'Delete', name: 'delete'},
            ]
        }
    }

 ];

export default class PaginationForEmployeeRecord extends NavigationMixin(LightningElement) {
 @track columns = COLS;
@track v_Offset=0;
@track v_TotalRecords;
@track page_size = 10;
data = [];
searchKey;
searchKeyModal = true;

//Fetching records from apex class
@wire(getEmployeeList, { v_Offset: '$v_Offset', v_pagesize: '$page_size' }) employees;

//Executes on the page load
connectedCallback() {
    totalRecords().then(result=>{
        this.v_TotalRecords = result;
    });
}

handleSearchChange(event){
 this.searchKey = event.target.value;
 console.log(this.searchKey);
 listOfSeachableRecord({searchKey: this.searchKey}).then(data =>{
    if(data != null){
        this.searchKeyModal = false;
        this.data = data;
    }
    
 })
}

previousHandler2(){
    getPrevious({v_Offset: this.v_Offset, v_pagesize: this.page_size}).then(result=>{
        this.v_Offset = result;
        if(this.v_Offset === 0){
            this.template.querySelector('c-paginator').changeView('trueprevious');
        }else{
            this.template.querySelector('c-paginator').changeView('falsenext');
        }
    });
}



nextHandler2(){
    getNext({v_Offset: this.v_Offset, v_pagesize: this.page_size}).then(result=>{
        this.v_Offset = result;
       if(this.v_Offset + 10 > this.v_TotalRecords){
            this.template.querySelector('c-paginator').changeView('truenext');
        }else{
            this.template.querySelector('c-paginator').changeView('falseprevious');
        }
    });
}

changeHandler2(event){
    const det = event.detail;
    this.page_size = det;
}
firstpagehandler(){
    this.v_Offset = 0;
    this.template.querySelector('c-paginator').changeView('trueprevious');
    this.template.querySelector('c-paginator').changeView('falsenext');
}
lastpagehandler(){
    this.v_Offset = this.v_TotalRecords - (this.v_TotalRecords)%(this.page_size);
    this.template.querySelector('c-paginator').changeView('falseprevious');
    this.template.querySelector('c-paginator').changeView('truenext');
}

handleRowAction(event){
    const actionName = event.detail.action.name;
    if(actionName == 'edit'){
      this.getThis();
    }else if(actionName == 'delete'){
        console.log(actionName);
    }
        
       
    
}
getThis(){
    this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes: {
           objectApiName : 'Account',
           actionName : 'list'
        },
       state:{
          filterName : 'Recent'
          
       }

  })

}

}
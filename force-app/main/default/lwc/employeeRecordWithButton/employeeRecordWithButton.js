import { LightningElement, track} from 'lwc';
import getRecord from '@salesforce/apex/GetActiveEmployeeRecord.getRecord';
import getFullRecord from '@salesforce/apex/GetActiveEmployeeRecord.getFullRecord';



const columns = [
    {label: 'Employee Name', fieldName:'Name'},
    {label: 'Email', fieldName:'Email_Address__c'},
    {
        
       label:'Get Details', type: 'button',
        typeAttributes : {
            label: 'Get Employee Details',
            name: 'View',
            version: 'brand',
            value: 'view',
            iconPosition: 'left',
            iconName:'utility:preview',

        }
    },
]

export default class EmployeeRecordWithButton extends LightningElement {
    
    columns = columns;
    data = [];
    empData = [];
    @track isModalOpen = false;

    connectedCallback(){
        getRecord().then(data => {
            console.log(data);
            this.data = data;
        })
    }

    handleRowAction(event){
        const recId = event.detail.row.Id;
        console.log(recId);
        
       getFullRecord({employeeId : recId}).then(data =>{
        console.log(JSON.stringify(data));
           if(data){
            this.empData = data;
            console.log('this is the data-->'+ JSON.stringify(this.empData));
            console.log(this.empData);
           }else{
            console.log('there is no data');
           }
      }).catch(error =>{
          console.log('There is some '+ error);
      });
      this.isModalOpen = true;
        


    }

   
   

    handleClick(recId){
        console.log(`This is the way ${recId}`);
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
    }

}
import { LightningElement } from 'lwc';
import EMPLOYEE_OBJECT from '@salesforce/schema/Employee__c';
import { NavigationMixin } from 'lightning/navigation';

export default class CreateNewEmployeeRecord extends NavigationMixin(LightningElement) {
    isModalOpen = false;
    objectApiName = EMPLOYEE_OBJECT;

    onClickHandler(){
        console.log("This clickable");
        this.isModalOpen = true;

    }
    closeModal(){
        this.isModalOpen = false;
    }

    onSuccess(event){
        console.log('this is working');
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
               recordId: event.detail.id,
               actionName : 'list'
            },
          
  
      })
    }

}
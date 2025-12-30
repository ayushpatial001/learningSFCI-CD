import { LightningElement, api } from 'lwc';
import  LEAVE_OBJECT from '@salesforce/schema/Leave__c';
import { NavigationMixin } from 'lightning/navigation';


export default class CreateLeaveRecord extends NavigationMixin(LightningElement) {
    objectApiName = LEAVE_OBJECT;
    @api recordId

    handleonsucces(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
               recordId: event.detail.id,
               actionName : 'view'
            },
          
  
      })

    }
}
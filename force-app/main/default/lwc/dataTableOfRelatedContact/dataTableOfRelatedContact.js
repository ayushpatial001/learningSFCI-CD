import { LightningElement } from 'lwc';
import getContacts from '@salesforce/apex/AccountRelatedContacForLWC.getContacts';

const columns = [
    {label: 'Name', fieldName: 'Name'},
    {label: 'Email', fieldName: 'Email'},
    {label: 'Phone', fieldName: 'Phone'}

];

export default class DataTableOfRelatedContact extends LightningElement {
    data = [];
    columns = columns;
    accountName;


    connectedCallback() {
        getContacts({accountId : '001dM000008cORJQA2'})
        .then(data=>{
            
            this.data = data;
            console.log('data' , this.data);
            this.accountName = this.data[0].Account.Name;
            console.log(this.accountName);
        })
        .catch(error=>{
            console.log(error);
            
        })
    }

}
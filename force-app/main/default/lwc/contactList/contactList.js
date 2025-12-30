import { LightningElement, wire} from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email';
import { reduceErrors } from 'c/ldsUtils';


const columns = [
    {label: 'FirstName', fieldName: FIRST_NAME.fieldApiName, type: 'text' },
    {label: 'LastName', fieldName: LAST_NAME.fieldApiName, type: 'text'},
    {label: 'Email', fieldName: EMAIL.fieldApiName, Type: 'text'}
]

export default class ContactList extends LightningElement {
    
    columns = columns;
   
    data = []; 

   @wire(getContacts)
   getContactData({error, data}){
    if(data){
        console.log('data-->', data);
        this.data = data;
    }else{
        console.log('error-->',error);
    }
   }

   get errors() {
    return (this.data.error) ?
        reduceErrors(this.data.error) : [];
}

   







}
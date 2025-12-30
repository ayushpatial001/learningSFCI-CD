import { LightningElement } from 'lwc';
import { publish, subscribe,  APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import msgService from '@salesforce/messageChannel/GetDataProperty__c';
export default class DetailedPropetyInformation extends LightningElement {
 
 connectedCallback() {
    this.subscription = subscribe(
    this.messageContext,
    msgService,
    (message) => this.handleMessage(message)
   );
   console.log("THIS IS MESAGE CONTEXT", message);
 }

}
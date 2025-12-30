import { LightningElement,wire } from 'lwc';
import {  subscribe ,  MessageContext } from 'lightning/messageService';
import MovieMessageChannel from '@salesforce/messageChannel/Get_Case__c';


export default class MovieLwcComponent extends LightningElement {
    subscription = null;
    data = [];
    subscription = null;
  
    @wire(MessageContext)
    messageContext;
  
    connectedCallback(){
             this.subscriptionToMessageChannel();
    }
  
    subscriptionToMessageChannel(){
      this.subscription = subscribe(this.messageContext,
        MovieMessageChannel,
        (message) => this.handleData(message),
      )
     
    }

    handleData(message){
     alert(message);
     console.log('this is the data-->', JSON.stringify(message));
    }
}
import { LightningElement,wire } from 'lwc';
 import {  subscribe ,  MessageContext } from 'lightning/messageService';
 import SAMPLE_MESSAGE_CHANNEL from '@salesforce/messageChannel/Get_Case__c';
 import listOfParticularCase from '@salesforce/apex/GetCases.listOfParticularCase';

export default class LMSSubscribe extends LightningElement {
  data = [];
  subscription = null;

  @wire(MessageContext)
  messageContext;

  connectedCallback(){
           this.subscriptionToMessageChannel();
  }

  subscriptionToMessageChannel(){
    this.subscription = subscribe(this.messageContext,
      SAMPLE_MESSAGE_CHANNEL,
      (message) => this.handleData(message),
    )
  }

  handleData(message){
    listOfParticularCase({caseId: message.recordId}).then(data =>{
      if(data){
        console.log('there is the data',data);
        this.data = data;
      }
    })
  }
 
}
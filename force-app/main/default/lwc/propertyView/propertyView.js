import { LightningElement,wire,track,api } from 'lwc';
import LightningStudio from '@salesforce/apex/GetPropertyData.LightningStudio';
import {refreshApex} from '@salesforce/apex';
import LightningModal from 'lightning/modal';
import { publish, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import msgService from '@salesforce/messageChannel/GetDataProperty__c';

export default class PropertyView extends LightningElement(LightningModal) { 


   @track data;
   @api
   horizontalAlign = ''; 
   @track newProperty = false;

   @wire(MessageContext)
   messageContext;
   
   connectedCallback() {
      // call apex method
      LightningStudio().then((result) => {
        if(result){
           this.data = result;
           console.log("this.data",result);
        }
      }).catch((err) => {
        console.log("This is the error", err);
      });
   }

   handleClick(evt){
      console.log('this is working');
       this.newProperty = true;
       
   }

   getParticularPropertyData(event){
      
      console.log("This is the data", event.currentTarget.dataset.propertyid);
      const messagePayload = {
           recordId: event.currentTarget.dataset.propertyid,
             
      };
      publish(this.messageContext, msgService, messagePayload);
   }

  

    handleStatusChange(event){
      console.log(event.detail.status);
       if (event.detail.status === 'FINISHED') {
        refereshThisPage();
         
    }
     }


     refereshThisPage(){
      console.log('This is first step');
      refreshApex(this.data);
      console.log('This is Second Step');
     }

     hideModalBox(){
       this.newProperty = false;
     }




    }
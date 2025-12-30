import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from  'lightning/platformShowToastEvent';
import { FlowNavigationEvent } from 'lightning/flowSupport';

export default class ShowToastInFlow extends LightningElement {
   @api title;
   @api message;
   @api variant;
   @api mode;


   connectedCallback(){
    this.handleShowToast();

   }


   handleShowToast(){
     const event = new ShowToastEvent({
           title: this.title,
           mode: this.mode,
           message: this.message,
           variant: this.variant
     });
     this.dispatchEvent(event);
     location.reload();
   }


  




}
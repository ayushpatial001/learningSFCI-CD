import { LightningElement } from 'lwc';
import sendMessage from '@salesforce/apex/SendSMS.sendMessage';

export default class SendSMS extends LightningElement {

    number = 0;
    message = '';

    getValue(event){
       console.log(event.target.value);
       this.number = event.target.value;
    }

    getMessage(event){
       console.log(event.target.value);
       this.message = event.target.value;
    }

    SendToMessage(){
      sendMessage({toNumber: this.number, message: this.message }).then(data =>{
         if(data){
           console.log('this is working');
         }else{
            console.log('this is not working');
         }
      })
    }

}
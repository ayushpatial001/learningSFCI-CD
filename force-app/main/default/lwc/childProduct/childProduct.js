import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from  'lightning/platformShowToastEvent';




export default class childFood extends LightningElement {
    @api fetch;
    data = [];


    connectedCallback(){
        console.log('this is the data',this.fetch);
        if(this.fetch){
              console.log('there is some data');
              this.data = this.fetch;  
        }
    }

  
 


}
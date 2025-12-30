import { LightningElement,wire,track } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import msgService from '@salesforce/messageChannel/GetDataProperty__c';
import dataRepresent from '@salesforce/apex/propertyVersion2.getData';


export default class ShowPropertyFullInformation extends LightningElement {

    subscription = null;
    @track data;
    @track value = false;

    @wire(MessageContext)
    messageContext;
    visibledatacomponent = false;

    connectedCallback() {
        
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel(){
        this.subscription = subscribe(
            this.messageContext,
            msgService,
            (message) => this.handleMessage(message)
        )
    }

    handleMessage(message){
        console.log('This the message', JSON.stringify(message.recordId));
        let storeId = message.recordId;
        console.log(storeId);
        dataRepresent({recrodData: storeId}).then(result => { if (result) {
             console.log('This is the result', result); 
              this.data = result;
              this.visibledatacomponent =true;
             }
         else { console.log('There is some error'); } 
         }).catch(error => { console.error('Error during data retrieval', error);
          });
    }

    onHandleChangeInput(event){
       
       console.log("This is the data",event.target.value);
    }

    handleOnClick(){
        debugger;
        let searchCmp = this.template.querySelector('.nameCmp');
        searchCmp.classList.add("acsd")
        
        

    }



}
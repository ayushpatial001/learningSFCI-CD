import { LightningElement,track,wire } from 'lwc';
import listOfCases from '@salesforce/apex/GetCases.listOfCases';
import { publish,  APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import SAMPLE_MESSAGE_CHANNEL from '@salesforce/messageChannel/Get_Case__c';

const columns = [
    {label: "Case Number" , fieldName:"CaseNumber"},
    {label : "Priority", fieldName: "Priority"},
    {label: 'Get Details', type: 'button',
        typeAttributes :  {
            label: 'Get Details',
            name: 'Contacts',
            version : 'brand',
            iconPosition :'left',
            iconName:'utility:preview',

        }
    }
]

export default class LMSPublish extends LightningElement {
    @track columns = columns;
   @track data = [];


   @wire(MessageContext)
   MessageContext




    connectedCallback(){
        listOfCases().then(data =>{
            if(data){
                console.log('this is the data',data);
                 this.data = data;
            }
        })
    }

    handleRowAction(event){
        console.log('dsddf',event.detail.row.Id);
          const payload = {
            recordId : event.detail.row.Id
          }

          publish(this.MessageContext,SAMPLE_MESSAGE_CHANNEL,payload);
    }

}
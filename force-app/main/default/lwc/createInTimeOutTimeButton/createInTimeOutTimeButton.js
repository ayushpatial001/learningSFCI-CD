import { LightningElement, track } from 'lwc';
import makeData from '@salesforce/apex/makeNewTimeEntryRecord.makeData';
import updateData from '@salesforce/apex/makeNewTimeEntryRecord.updateData';
import checkTodayHasData from '@salesforce/apex/makeNewTimeEntryRecord.checkTodayHasData'; 

export default class CreateInTimeOutTimeButton extends LightningElement {
    @track secondname; 
    @track firstname; 

     connectedCallback(){
        checkTodayHasData().then(data => {
            if(data){
                console.log('Data is coming value is true');
                this.secondname = true;
                this.firstname = true;
             }else{
                console.log('data is coming value is false');
                this.secondname = true;
                this.firstname = false;
             }
        });
        
        
     }

    inHandler(){
        this.secondname = false;
        this.firstname = true;
        console.log('This is working');
        makeData().then(data => {
           if(data){
              console.log('there is some data');
           }else{
              console.log('there is no data');
           }
        });
        
    }

    outHandler(){
        this.secondname = true;
        this.firstname = true;
        updateData().then(data =>{
            if(data){
                console.log("second handler");
            }else{
                console.log("third handler");
            }
        })


    }

}
import { LightningElement } from 'lwc';
import task from '@salesforce/schema/Account';

export default class Activity extends LightningElement {
    objectApiName = task
    showDifferentThings =false;


    handleClick(){
        console.log('This is working');
        this.showDifferentThings =true;
    }

    HidePanel(){
        this.showDifferentThings = false;   
    }

    
}
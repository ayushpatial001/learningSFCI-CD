import { LightningElement,wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getData from'@salesforce/apex/BuildFromBrick.getData';
export default class BuildFromBrick extends LightningElement {
     searchTerm = '';
    // FIRST We learn what is wire and what is the diffeence between wire as property and wire as function 
     // wire is the  auto - call , auto refresh - Think of it like a live subscription (a stock ticker) vs. 
     //a one-time order (calling a shop to ask a price). @wire is the ticker — it just keeps feeding you fresh data.

    @wire(getData , {Name : '$searchTerm'}) getData;

    handleChange(event){
         this.searchTerm = event.target.value;

    }

    handleOnButtonChange(event){
        refreshApex(this.getData.data);
    }

}
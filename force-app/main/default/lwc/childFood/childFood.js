import { LightningElement,api,track } from 'lwc';
import methodName1 from '@salesforce/apex/ChildFoodController.methodName1';
import { ShowToastEvent } from  'lightning/platformShowToastEvent';


export default class childFood extends LightningElement {
    @api detail;
    selectedName ;
    Price;
    @track TotalPrice = 0;
    quantityAll = 0;
    storeSameIdData = new Map();
    AllnameOfItem = '' ;
    sendAllDataToDatabase;
    


    connectedCallback(){
        if(this.detail.length > 0){
           
            this.detail.forEach(element => {
                console.log('element'+ JSON.stringify(element));
                console.log('element.Price' + element.Price__c);
                console.log('element.Price' + element.quantity);
                this.AllnameOfItem += element.Name + ',';
                this.quantityAll += parseInt(element.quantity);
                this.TotalPrice += parseInt(element.Price__c)  * parseInt(element.quantity);
                 
            })
              
            
           
          console.log(this.AllnameOfItem);
          console.log( this.quantityAll );
          console.log(this.TotalPrice);
          this.sendAllDataToDatabase = {Name:this.AllnameOfItem, Quantity:  this.quantityAll, TotalPrice: this.TotalPrice};
          console.log(this.sendAllDataToDatabase);
          
           
          ;
           
        }
    }

    handleClick1(){
        console.log('Enter in handle click');
       this.dispatchEvent(new CustomEvent('backtomenu'));
            
    }
    handleClick(){
        console.log('this is working');
        methodName1({nameOfItem: this.AllnameOfItem, totalQunatity:this.quantityAll, totalaPrice: this.TotalPrice}).then(data => {
            if(data){
                console.log("This is the data -->"+ data);
                const event = ShowToastEvent({
                      title: 'Success',
                      message: 'Your Order Placed Send Successfully',
                });
                this.dispatchEvent(event);
            }
        })
    }


}
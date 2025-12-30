import { LightningElement,wire,track } from 'lwc';
import getProductsWithPricesAndImages from '@salesforce/apex/ProductImageClass.getProductsWithPricesAndImages';
import { publish,  APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import SAMPLE_MESSAGE_CHANNEL from '@salesforce/messageChannel/Get_Product__c';
import { ShowToastEvent } from  'lightning/platformShowToastEvent';
import ADD_TO_CART from '@salesforce/resourceUrl/Add_to_cart';

const option1 = [
    {
     label:'INR', value:'INR',
    },
    {label: 'Dollar', value: 'Dollar'}
]

export default class AssignmentOfProduct extends LightningElement {
    @track imgOfCart = ADD_TO_CART;
    data = [];
    storedObjectData = [];
    ObjectLength = 0;
    showDetailButton = false;
    recordSize = 4;
    pageNumber = 1;  
    productToDisplay;
    totalRecords ;
    totalPages;
    options = option1;
    addtoCart = [];
    button;
    isdisabled = false;
    map1 = new Map();
    count = 0;
   

    @wire(MessageContext)
    messageContext

    connectedCallback(){ 
       
        getProductsWithPricesAndImages().then(data => {
            console.log('data - ',data);
           
       
            if(data.length > 0){
                  this.data = data.map(data => {
                    return {
                        ...data,
                        quantity: 0,
                        disabled: false,
                        totalprice: 0,
                    }
                  })
                
                console.log('this.data', this.data);
                this.totalRecords = this.data.length;
                this.totalPages = Math.ceil(this.totalRecords/this.recordSize);
                this.paginationController();
            }
        });
       

    }

    //combobox
    handleChange(event){
        this.status = event.target.value;
        if(this.status == 'INR'){
            const event1 = new ShowToastEvent({
                title: 'Currently No Filter is there',
                message: 'No data',
                variant: 'destructive'
            });
            this.dispatchEvent(event1);
    
        }else if(this.status == 'Dollar'){
            const event1 = new ShowToastEvent({
                title: 'Currently No Filter is there',
                message: 'nodata',
                variant: 'destructive'
            });
            this.dispatchEvent(event1);
    
        }
    }

    paginationController() {
        console.log('this pagination is called')
        this.productToDisplay = [];
      // calculating start and end point
      const start = ((this.pageNumber - 1) * this.recordSize);
      const end = Math.min(start + this.recordSize, this.data.length);;
    
      // adding records in temp list productToDisplay from main list productList, this loop runs from start point to end point
      for (let i = start; i < end; i++) {
          this.productToDisplay.push(this.data[i]);
      }

      console.log('this.productToDisplay', this.productToDisplay);

    }

   
    handlePrevious(){
      this.pageNumber = this.pageNumber - 1;
      this.paginationController();
    }
    
   
    handleNext(){
      this.pageNumber = this.pageNumber + 1;
      this.paginationController();
    }
    
    
    get handleDisablePrevious() {
      return this.pageNumber === 1;
    }
    
    
    get handleDisableNext() {
      return this.pageNumber === this.totalPages;
    }
    

    Add(event){

        this.productToDisplay.forEach(element => {
            if (element.productId == event.currentTarget.dataset.id) {
                element['quantity'] += 1;
                element['totalprice'] = element['quantity'] * element['price'];
                if(this.map1.has(element.productId)){
                   console.log('enter in the map'); 
                  this.map1.get(element.productId);                 
                }else{
                    console.log('enter in else part');  
                 this.map1.set(element.productId, element);
                 element['disabled'] = true;

                }
                this.ObjectLength = element['quantity'];

            }
        });

      
     
        const event1 = new ShowToastEvent({
            title: 'New Item Added',
            message: 'New Item Added',
            variant: 'success'
        });
        this.dispatchEvent(event1);


        
    }

    Remove(event){
        this.productToDisplay.forEach(element => { 
            if(element.productId == event.currentTarget.dataset.id){
                if(element["quantity"]  == 0){
                    element["quantity"]  =  0;
                    element['totalprice'] = element['quantity'] * element['price'];
                }else{
                    element["quantity"]  -=  1;
                    element['totalprice'] = element['quantity'] * element['price'];
                }
                if(this.map1.has(event.currentTarget.dataset.id)){
                    this.map1.get(event.currentTarget.dataset.id);
                     
                  }else{
                   this.map1.set(event.currentTarget.dataset.id, element);
                   element['disabled'] = true;
                  }
                  this.ObjectLength = this.ObjectLength = element['quantity'];
 

            }
          
        });
       

        const event2 = new ShowToastEvent({
            title: 'Item Removed',
            message: 'Item Removed Successfully',
            variant: 'error',
        });
        this.dispatchEvent(event2);

    }

   
  


    AddtoCart(event){
        this.productToDisplay.forEach(element => {
            console.log(element);
            
            if(element.productId == event.currentTarget.dataset.id){
                element['quantity'] += 1;
                element['disabled'] = true;
                element['totalprice'] = element['quantity'] * element['price'];
                     
                this.map1.set(event.currentTarget.dataset.id, element);
                    
                  
                   
                  
                console.log('this is the data',this.map1);
                
                this.ObjectLength = this.ObjectLength = element['quantity'];
                console.log('This is object length',this.ObjectLength);

            }
        });
        
        console.log('this.storedObjectData.length', this.storedObjectData.length); 
        
        console.log(event);
        const event1 = new ShowToastEvent({
            title: 'New Item Added',
            message: 'New Item Added',
            variant: 'success'
        });
        this.dispatchEvent(event1);


        
        

    }

    handleClick(event){
        console.log('this is working');
        const payload = {
            recordId : event.currentTarget.dataset.id
          }
          console.log('This is the payload-->', payload);
          publish(this.messageContext,SAMPLE_MESSAGE_CHANNEL,payload);


    }


    handleCart(){
        // Initialize an empty list to store the values
            let list = [];

         // Iterate over the values in the map
        for (let val of this.map1.values()) {
            console.log('val',val);
           list.push(val); // Add each value to the list
        }
         // Now 'list' contains all the values from the map
         console.log('List of values from map', list);
        this.storedObjectData = list;
        console.log('this object',this.storedObjectData);
        console.log('this.map1.size',this.map1.size);
        if(this.ObjectLength == 0){
            const event = new ShowToastEvent({
                title: 'Cart Is Empty',
                message: 'Please Add some item in cart first',
                variant: 'Info'
          });
          this.dispatchEvent(event);
        }else{
            this.showDetailButton =true;
        
        }
       
    }

   
    

}
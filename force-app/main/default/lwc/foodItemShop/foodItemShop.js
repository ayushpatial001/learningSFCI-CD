import { LightningElement,wire,track } from 'lwc';
import getFoodItems  from '@salesforce/apex/GetAllFoodItems.getFoodItems';
import getFoodItem from  '@salesforce/apex/GetAllFoodItems.getFoodItem';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import FOOD_ITEM from '@salesforce/schema/Food_Item__c';
import CATEGORY from '@salesforce/schema/Food_Item__c.Category__c';
import SUB_CATEGORY from '@salesforce/schema/Food_Item__c.Sub_Category__c';
import { ShowToastEvent } from  'lightning/platformShowToastEvent';
import ADD_TO_CART from '@salesforce/resourceUrl/Add_to_cart';



export default class FoodItemShop extends LightningElement {
@track imgOfCart = ADD_TO_CART;
Quantity = 0;
recordTypeId;
@track subOption = [];
@track category;
@track subCategory;
@track data = [];
storedObjectData = [];
@track ObjectLength = 0;
showDetailButton = false;
@track evtName;
storeCartId = new Map();

// Here I get the object defaultRecordTypeId

 @wire(getObjectInfo,{ objectApiName: FOOD_ITEM})
 foodItemInfol({data, error}){
    if(error){
      console.log('object'+JSON.stringify(error));
    }else if(data){
        console.log(data.defaultRecordTypeId);
        this.recordTypeId = data.defaultRecordTypeId;
    }
 }
 


// Now After store the recordId Now i get the Picklist Field Value
 @wire(getPicklistValues,{recordTypeId: '$recordTypeId', fieldApiName : SUB_CATEGORY})
 getData1({data,error}){
    if(error){
        console.log('SubCategory'+JSON.stringify(error));
    }else if(data){
        console.log('Subcategory'+ JSON.stringify(this.subCategory));
      this.subCategory = data.values;
    }
 }
 

 // 2nd Picklist Value get from that same object

 @wire(getPicklistValues,{recordTypeId: '$recordTypeId', fieldApiName : CATEGORY})
 getData({data,error}){
    if(error){
        console.log('error category'+ JSON.stringify(error));
    }else if(data){
        console.log('this is working good');
        console.log('real value category'+ this.category);
        this.category = data.values;
    }
 }
  
 //This button isclick on add to cart and go to child element  also hide the parent component
 // and show children component

 showDetailButton1(){
    if(this.ObjectLength == 0){
        const event = new ShowToastEvent({
            title: 'Cart Is Empty',
            message: 'Please Add some item in cart first',
            variant: 'Info'
      });
      this.dispatchEvent(event);
    }else{
        this.showDetailButton = true;
    }
    
     
 }
 



 



  // This method filter the data to store in dependent picklist value this is actually paln
  // of trishul bhai 
 handleSelection(event){
          this.status =  event.target.value;
          
          console.log(this.status);
          if(this.status == 'Non-Veg'){
            this.subOption  = this.subCategory.filter(data => {
                if( data.label.includes("🟢")){
                    return data.value;
                }
               
            })
        }else if(this.status == 'Veg'){
            this.subOption  =  this.subCategory.filter(data => {
                if( data.label.includes("🔴")){
                    return data.value;
                }
               
            })
        }
       
         
        }

      

// connected callback that helps to call and fetch the data on render the ui
    connectedCallback(){
        getFoodItems().then(data => {
            console.log('data - ',data);
            // add one field from js in object for particular record --> quatity
            data.forEach(element => {
                element["quantity"] = 0;
                console.log('element - ',element);
            });
            console.log('datat - ',data);
            console.log('There is all data ' + JSON.stringify(data));
            
            if(data.length > 0){
                this.data = data;
                console.log('This is the store data-->'+ JSON.stringify(data));
            }
        })
    }


    // this handler handle custom events that call from the child custom component

    NavigateToParentComp(){
        console.log('This is wokring when we navigate through');
        this.showDetailButton = false;
        const event = new ShowToastEvent({
            title: 'Working',
            message: 'This is working',
            variant: 'success'
      });
      this.dispatchEvent(event);
    }

   
 // this is the button that give me the particular record id and also we store qauntity in this

    handleClick(event){
        
        console.log('event.data',event.target.dataset);
        
        let recordId = event.currentTarget.dataset.id;

        this.data.forEach(element => {
            console.log(element);
            
            if(element.Id == event.currentTarget.dataset.id){
                console.log('elementId-->',element.Id);
                console.log('event.dataset',event.currentTarget.dataset.id);

                //this.Quantity += 1;

                element["quantity"] += 1;
                console.log(this.storedObjectData);
              
                this.storedObjectData.push(element);
                console.log('This is the storeObject -->'+ JSON.stringify(this.storedObjectData));
                this.ObjectLength =  this.storedObjectData.length;

            }
        });

          console.log()
        this.storedObjectData.map(element => {
            this.storeCartId.set(element.Id, element);
        });

        console.log('This is the filled map', JSON.stringify(this.storeCartId));
       
        
        console.log(event);
        const event1 = new ShowToastEvent({
            title: 'New Item Added',
            message: 'New Item Added',
            variant: 'success'
        });
        this.dispatchEvent(event1);


        
    }

    // remove the item
    RemoveItem(event){
        console.log('this is working');
        this.data.forEach(element => { 
            console.log('This is working', element.Id , event.currentTarget.dataset.Id );
            if(element.Id == event.currentTarget.dataset.id){
                console.log('elementId-->',element.Id);
                console.log('event.dataset -->',event.currentTarget.dataset.id);
                console.log('After-->'+element['quantity']);
                if(element["quantity"]  == 0){
                    element["quantity"]  =  0;
                }else{
                    element["quantity"]  -=  1;
                }
                
                console.log('Before-->'+element['quantity']);
                console.log(this.storedObjectData);
                this.storedObjectData.pop(element);
                console.log('This is the storeObject -->'+ JSON.stringify(this.storedObjectData));
                console.log(this.storedObjectData.length);
                this.ObjectLength =  this.storedObjectData.length;

            }
            console.log('this is the end');
        });

        const event2 = new ShowToastEvent({
            title: 'Item Removed',
            message: 'Item Removed Successfully',
            variant: 'error',
        });
        this.dispatchEvent(event2);

    }


    //sendData
    sendata(event){

        const data = event.detail.value;
        console.log('This comes from '+data.Name);
        console.log('this comes form child'+data.quantity);
       
        storeFood({name: data.Name, quantity: data.quantity, totalPrice: data.totalPrice}).then(data =>{
            console.log(data);
        })
    }

    

    
   // this call on second filter 
    handleSelection1(event){
        let subcategory = event.target.value;
        console.log(subcategory);
        getFoodItem({category: this.status, subCat: subcategory}).then(data =>{
            data.forEach(element => {
                element["quantity"] = 0;
                console.log('element - ',element);
            });
           this.data = data;
           console.log(this.data);
        })

    }
}
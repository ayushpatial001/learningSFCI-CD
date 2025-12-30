import { LightningElement,api } from 'lwc';
import makePayments from '@salesforce/apex/ProductImageClass.makePayments'

const columns = [
    {label: 'Name', fieldName:'name' },
    {label: 'Price', fieldName: 'price'},
    {label: 'Quantity', fieldName: 'quantity',  editable: true},
    {label: 'Total Price', fieldName: 'totalprice'},
    { type: 'button',
        typeAttributes: { iconName: 'utility:delete', label: 'Remove', name: 'action' }
    }
    
     
]

export default class ChildProductSecond extends LightningElement {
    @api detail;
    columns  = columns; 
    sgst = 12;
    cgst = 5;
    totalPrice = 0;

    connectedCallback(){

        console.log('this.detail',this.detail);
        this.calculateTotalPrice();
    }

    calculateTotalPrice() {  
        this.totalPrice = this.detail.reduce((acc, product) => acc + product.totalprice, 0);  
        const totalGST = (this.totalPrice * (this.sgst + this.cgst)) / 100;  
        this.totalPrice += totalGST;  
        console.log('Total Price after calculation:', this.totalPrice);  
    }  

    removeElement(event) {
       console.log();
     
       this.detail = this.detail.filter(product => product.productId !== event.detail.row.productId);
       this.calculateTotalPrice();
    
    }

    onHandleclick(){
        console.log('The total Amount is-->', this.totalPrice);
        console.log('The total in Integer-->', parseInt(this.totalPrice));
        let fixValue = parseInt(this.totalPrice);
        makePayments({totalAmount : fixValue}).then( data => {
            if(data){
                console.log('This is data',data);
            }else{
               console.log('There is some error');
            }
        }
           
        )
    }



    


       
        
    

}
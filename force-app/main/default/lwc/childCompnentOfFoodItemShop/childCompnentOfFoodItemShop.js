import { LightningElement,api } from 'lwc';

export default class ChildCompnentOfFoodItemShop extends LightningElement {
    @api detail;

    connectedCallback(){
        if(this.detail.length > 0){
            
        }
    }
}
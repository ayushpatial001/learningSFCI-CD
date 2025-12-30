import { LightningElement } from 'lwc';
import getWorkAnniversary from '@salesforce/apex/FindBirthdateAndWorkAnniversary.getWorkAnniversary';
import getBirtDate from '@salesforce/apex/FindBirthdateAndWorkAnniversary.getBirtDate';
import BIRTHDAY_ICON from "@salesforce/resourceUrl/birthday_pg";

export default class ShowBirthdayAndWorkAnniversary extends LightningElement {
    birthdayIcon = BIRTHDAY_ICON;
    data1 = [];
    data2 = [];


    connectedCallback(){
        getWorkAnniversary().then(data=>{
            console.log('This is the data-->'+data);
             if(data.length > 0){
              this.data1 = data;
              console.log('This is the stored first data-->'+this.data);
             }
        });

        getBirtDate().then(data=>{
            console.log('This is the  2nd data-->'+data);
            if(data.length > 0){
             this.data2 = data;
             console.log('This is the 2nd stored first data-->'+this.data);
            }

        })


    }
}
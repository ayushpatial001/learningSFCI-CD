import { LightningElement } from 'lwc';
import APPLE_LOGO from "@salesforce/resourceUrl/applsvg";
import SEARCH_ICON from "@salesforce/resourceUrl/searchicon";
import BAG_ICON from "@salesforce/resourceUrl/bagIcon";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import LightningAlert from 'lightning/alert';


export default class AppleWebsite extends LightningElement {
   hamuger1 = APPLE_LOGO;
   searchIcon = SEARCH_ICON;
   bagIcon = BAG_ICON;
    

   handleOnClick(){
      
      console.log('This is working');
      LightningAlert.open({

         label : 'Thank you for visiting us!',
   
         message : 'Please note that you are now being redirected to an external website.',
   
         theme : 'success'
   
            });
      this.dispatchEvent(
         new ShowToastEvent({
             title: 'Success',
             message: 'Account created',
             variant: 'success',
         }),
     );
     
         console.log('this is again working');
     

   }
 


}
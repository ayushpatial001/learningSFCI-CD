import { LightningElement, api , wire , track } from 'lwc';
import { getRecords } from 'lightning/uiRecordApi';
import NAME_FIELD from "@salesforce/schema/User.Name";
import EMAIL_FIELD from "@salesforce/schema/User.Email";




export default class UserProfileVisibilty extends LightningElement {
    showEmail = false ;
    

     @wire(getRecords, {
    records: [
        {
        recordIds: ["005dM000002FDmHQAW", "005dM000002dTpCQAU"],
        fields: [NAME_FIELD],
        optionalFields: [EMAIL_FIELD],
         },
       ],
     })
     wiredRecords;
     

    checkresult(){
        console.log(
         JSON.parse(JSON.stringify(this.wiredRecords.data))
         );

    }

    set userName(val){
        
    }
    get emailButtonLabel() {
    return this.showEmail ? 'Hide Email' : 'Show Email';
    }

    get userName(){
       if (!this.wiredRecords?.data?.results?.length) {
        return '';
    }

    const name =
        this.wiredRecords.data.results[0].result.fields.Name.value;

    return name === 'Ayush Patial'
        ? 'MR Ayush Patial'
        : 'Miss Ayush Patial';
         
        
    }



    handleToggleEmail() {
        this.showEmail = !this.showEmail;
    }

    get users(){
        if (!this.wiredRecords?.data?.results) {
        return [];
    }
        return this.wiredRecords.data.results.map(items  => {
            const records  = items.result;


            return {
                id : records.fields.id,
                name : records.fields.Name.value,
                email : records.fields.Email.value
            }
        })

        
    }


    

    

}
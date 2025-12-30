import { LightningElement,api,wire} from 'lwc';
import getRelatedInformation from '@salesforce/apex/AccountRelatedContactCaseOpportunities.getRelatedInformation';

export default class AccountRelatedContactCaseOpportunity extends LightningElement {
    @api recordId;
    accountName;
    contactName;
    caseId = [];
    opportuintyName = [];


    @wire(getRelatedInformation,{accountId : '$recordId'})
    wiredMethod({data, error}){
        alert("this is working");
        console.log('data-->' + JSON.stringify(data));
        if(data){
            this.accountName = data.Name;
           console.log(this.accountName);
           this.contactName = data.Contacts;
           console.log(this.contactName);
           this.caseId = data.Cases;
           console.log(this.caseId);
           this.opportuintyName = data.Opportunities;
           console.log(this.opportuintyName);

        }else if(error){
           console.log(error);
        }
    }

    


}
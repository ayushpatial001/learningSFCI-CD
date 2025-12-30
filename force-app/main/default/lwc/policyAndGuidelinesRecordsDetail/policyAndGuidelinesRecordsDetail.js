import { LightningElement } from 'lwc';
import getPolicyRecordDetails from '@salesforce/apex/policyAndGuidelinesData.getData';

const columns = [
    {label: 'EmployeeName', fieldName: 'EmployeeName'},
    {label: 'Accepted Policies', fieldName: 'AcceptedPolicies'},
    {label: 'Remaining Policied',fieldName: 'RemainingPolicies'}
];

export default class PolicyAndGuidelinesRecordsDetail extends LightningElement {
    data = [];
    columns = columns;

    connectedCallback(){
        getPolicyRecordDetails().then(
            data=>{
                this.data = data;
                console.log('data18>> ' ,data);

                this.data.forEach(element => {
                    if(EmployeeName__c!=undefined){
                        element.EmployeeName = element.EmployeeName__r.Name;
                    }
                        
                });
                            }

        ).catch(error=>{
             console.log(error);
        })
    }

}
import { LightningElement, wire,track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountDetailsWithContactCasesOpp.getAccounts';
import contactRecords from '@salesforce/apex/AccountDetailsWithContactCasesOpp.contactRecords';
import caseRecords from '@salesforce/apex/AccountDetailsWithContactCasesOpp.caseRecords';
import getOpportunity from '@salesforce/apex/AccountDetailsWithContactCasesOpp.getOpportunity';


const columns = [
    {label: 'Name',  fieldName: 'Name'},
    {label: 'Email', fieldName: 'Email__c'},
    {label: 'Industry', fieldName: 'Industry'},
    {
        label: 'Get Contacts', type: 'button',
        typeAttributes: {
            label: 'Get Contacts',
            name: 'Contacts',
            version : 'brand',
            iconPosition :'left',
            iconName:'utility:preview',

        }
    },
    {
        label: 'Get Cases', type: 'button',
        typeAttributes: {
            label: 'Get Cases',
            name: 'Cases',
            version : 'neutral',
            iconPosition :'left',
            iconName:'utility:preview',

        }
    },
    {
        label: 'Get Opportunities', type: 'button',
        typeAttributes: {
            label: 'Get Opportunities',
            name: 'Opportunities',
            version : 'base',
            iconPosition :'left',
            iconName:'utility:preview',

        }
    },
];

export default class AccountDetailsWithContactOppCasesWithButtons extends LightningElement {
   @track isModalOpen = false;
    columns = columns;
    data = [];
    contactData = [];
    caseData = [];
    opportunityData = [];
    contactisEmpty ; 

    @wire(getAccounts)
    wireMethod({data,error}){
       if(data){
        this.data =data;
        console.log(data);
       }else if(error){
         console.log(error);
       }
    };

    handleRowAction(event) {
        const recId = event.detail.row.Id;
        const actionName = event.detail.action.name;
        if (actionName === 'Contacts') {
            this.handleContacts(recId);
        } else if (actionName === 'Cases') {
            this.handleCases(recId);
        } else if (actionName === 'Opportunities') {
            this.handleOpportunities(recId);
        }
    }

    handleContacts(recId){
        contactRecords({accountId: recId}).then(data =>{
            console.log('The Contact Data is -->'+ JSON.stringify(data));
            if(data){
                this.contactData = data;
                console.log('data-->'+data);
                this.contactisEmpty = true;
                if(this.contactData.length === 0){
                    console.log('there is no data');
                    this.contactisEmpty = false;
                }
            }else{
              
            }
        })
        this.isModalOpen = true;
       console.log('This is contact button' + recId);


    }

    handleCases(recId){
        caseRecords({accountId: recId}).then(data =>{
            console.log('The Case Data is -->'+ JSON.stringify(data));
            if(data){
                this.caseData = data;
                console.log('data-->'+data);
            }else{
                console.log('there is no data');
            }
        })
        this.isModalOpen = true;
       console.log('this is case button' + recId);
        
    }

    handleOpportunities(recId){
        getOpportunity({accountId: recId}).then(data =>{
            console.log('The Opportunity Data is -->'+ JSON.stringify(data));
            if(data){
                this.opportunityData = data;
                console.log('data-->'+data);
            }else{
                console.log('there is no data');
            }
        })
        this.isModalOpen  = true;
       console.log('this is opportunity button' + recId);
        
    }
   
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
        this.contactData = [];
       this.caseData = [];
       this.opportunityData = [];

    }
    

}
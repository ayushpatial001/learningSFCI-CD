import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

// Import fields you want
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class AccountViewer extends LightningElement {
    @api recordId; // recordId is passed automatically when component is on a record page

    // Wire adapter to fetch record data
    @wire(getRecord, { recordId: '$recordId', fields: [NAME_FIELD, PHONE_FIELD] })
    account;

    // Easy getters for field values
    get name() {
        return getFieldValue(this.account.data, NAME_FIELD);
    }
    get phone() {
        return getFieldValue(this.account.data, PHONE_FIELD);
    }
}
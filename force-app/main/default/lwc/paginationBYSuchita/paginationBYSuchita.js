import { LightningElement,wire } from 'lwc';
import getEmployees from '@salesforce/apex/paginationdata.getEmployees';
import updateEmployee from '@salesforce/apex/paginationdata.updateEmployee';
import deleteEmployee from '@salesforce/apex/paginationdata.deleteEmployee';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Email', fieldName: 'Email_Address__c', editable: true },
    { label: 'Gender', fieldName: 'Gender__c', editable: true },
    // Add more fields as needed
    {
        type: 'action',
        typeAttributes: {
            rowActions: [
                { label: 'Edit', name: 'edit' },
                { label: 'Delete', name: 'delete' }
            ]
        }
    }
];

export default class EmployeeRecords extends LightningElement {
    employees = [];
    columns = COLUMNS;
    draftValues = [];
    currentPage = 1;
    pageSize = 10;
    totalRecords = 0;
    disablePrevious = true;
    disableNext = false;

    @wire(getEmployees, { pageSize: '$pageSize', pageNumber: '$currentPage' })
    wiredEmployees({ error, data }) {
        if (data) {
            this.employees = data.records;
            this.totalRecords = data.total;
            this.disablePrevious = this.currentPage === 1;
            this.disableNext = this.currentPage * this.pageSize >= this.totalRecords;
        } else if (error) {
            this.showToast('Error', 'Error fetching employee records', 'error');
        }
    }

    handlePrevious() {
        if (this.currentPage > 1) {
            this.currentPage -= 1;
            this.fetchEmployees();
        }
    }

    handleNext() {
        if (this.currentPage * this.pageSize < this.totalRecords) {
            this.currentPage += 1;
            this.fetchEmployees();
        }
    }

    handleSave(event) {
        const updatedFields = event.detail.draftValues;

        updateEmployee({ data: updatedFields })
            .then(() => {
                this.showToast('Success', 'Records updated successfully', 'success');
                this.draftValues = [];
                this.fetchEmployees();
            })
            .catch(error => {
                this.showToast('Error', 'Error updating records', 'error');
            });
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'delete') {
            this.deleteEmployee(row.Id);
        }
    }

    deleteEmployee(employeeId) {
        deleteEmployee({ employeeId })
            .then(() => {
                this.showToast('Success', 'Record deleted successfully', 'success');
                this.fetchEmployees();
            })
            .catch(error => {
                this.showToast('Error', 'Error deleting record', 'error');
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({
            title,
            message,
            variant
        }));
    }

    fetchEmployees() {
        getEmployees({ pageSize: this.pageSize, pageNumber: this.currentPage })
            .then(result => {
                this.employees = result.records;
                this.totalRecords = result.total;
                this.disablePrevious = this.currentPage === 1;
                this.disableNext = this.currentPage * this.pageSize >= this.totalRecords;
            })
            .catch(error => {
                this.showToast('Error', 'Error fetching employee records', 'error');
            });
    }
}
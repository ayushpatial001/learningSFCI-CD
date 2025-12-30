import { LightningElement } from 'lwc';
import fetchTask  from '@salesforce/apex/TaskRelatedToCase.fetchTask';
const columns = [
    { label: 'Task Subject', fieldName: 'taskSubject' },
    { label: 'Case Subject', fieldName: 'Subject'  },
    { label: 'Status', fieldName: 'Status'},
    { label: 'Contact Name', fieldName: 'ContactName' },
    { label: 'CaseId', fieldName: 'CaseId'},
    { label: 'ActivityDate', fieldName: 'ActivityDate'},
];

export default class TaskAndCaseDataTale extends LightningElement {
     data = [];
    columns = columns;

    connectedCallback(){
        fetchTask().then(data =>{
            if(data){
                this.data = data;
                console.log('this is the task related data',this.data);
            }
        })
    }
}
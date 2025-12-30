import { LightningElement,api } from 'lwc';
import makeTimesheet from '@salesforce/apex/MakeTimesheetRecord.makeTimesheet';
import { NavigationMixin } from 'lightning/navigation';

export default class CreateTimesheet extends NavigationMixin(LightningElement) {
    @api recordId;
    data;
    isModalOpen = true;
    projectId;
    description;
    totalhour;
    handleChange( event ) {
        console.log(event.detail.recordId);
        }

        submitDetails(){
        this.isModalOpen = false;

       
    }

    Modaltag(){
        this.isModalOpen = false;
    }

    closeModal(){
        this.isModalOpen = false;
        makeTimesheet({EmployeeId: this.recordId,projectId: this.projectId, description: this.description,totalHour: this.totalhour}).then(data=>{
               console.log('this is the data'+data);
               this[NavigationMixin.Navigate]({  
                type: 'standard__recordPage',
                attributes: {
                   recordId: data,
                   actionName : 'view'
                },
          })
               
        });
        

    }
     
    SaveandNewModal(){
        makeTimesheet({EmployeeId: this.recordId,projectId: this.projectId, description: this.description}).then(data=>{
            console.log('this is the data'+data);     
     });
      location.reload();
      this.isModalOpen = true;
     

    }

    handleChange(event){
      this.projectId= event.detail.recordId
    }

    descriptionHandler(event){
        this.description = event.target.value;
       
    }

    totalhour(event){
       this.totalhour = event.target.value;
    }
}
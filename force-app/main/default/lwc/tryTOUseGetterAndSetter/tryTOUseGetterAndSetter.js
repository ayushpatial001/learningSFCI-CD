import { LightningElement } from 'lwc';
export default class TryTOUseGetterAndSetter extends LightningElement {
   name = 'Abhishek';
   changedAge = 22 ;
   newAge;


  handleInputData(event){
     this.newAge = event.target.value;
     console.log(this.newAge);
  }

  get age(){
    if(this.changedAge > 25){
        return this.changedAge = 25;
    }
    return this.changedAge;
  }

  set age(value){
    
    this.changedAge =  value;
  }

  onclickHandler(){
    this.age =  this.newAge;
  }

  
  
}
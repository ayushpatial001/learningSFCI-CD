import { LightningElement } from 'lwc';
import LightningAlert from 'lightning/alert';

export default class Calculator extends LightningElement {
     firstNumber = '';
     secondNumber = '';
     resultValue;
     
    handleNumberOeChange(event) {
        
         let dummy;
        dummy = 'hello';
        this.firstNumber = event.target.value;

        
        
    }
    handleNumberTwoChange(event) {
        this.secondNumber = event.target.value;
    }
    addition() {
        if(this.firstNumber == '' || this.secondNumber == ''){
            console.log("This block is if statement block");
            LightningAlert.open({
                message: 'Please input some value in the input field',
                theme: 'error', // a red theme intended for error states
                label: 'Error!', // this is the header text
            });
        }else{
            console.log(this.secondNumber);
            console.log(this.firstNumber);
            console.log(parseInt(this.firstNumber));
            console.log(parseInt(this.secondNumber));
            this.resultValue = (parseFloat(this.firstNumber) + parseFloat(this.secondNumber)).toFixed(2);
        }
        
    }
    multification() {
        console.log(this.secondNumber);
        console.log(this.firstNumber);
        this.resultValue = this.firstNumber * this.secondNumber;
    }
    subtraction() {
        this.resultValue =  (parseFloat(this.firstNumber)  - parseFloat(this.secondNumber)).toFixed(2);
    }
    division() {
        this.resultValue =  (parseFloat(this.firstNumber) / parseFloat(this.secondNumber)).toFixed(2);
    }
    random(){
        console.log("this is working");
        this.resultValue = Math.random();
        console.log(resultValue);
    }
    sinMethod(){
        if(this.firstNumber == null){
        console.log('THIS IS SINMETHOD');
            LightningAlert.open({
                message: 'Please Add Some Value in First Field',
                theme: 'error', // a red theme intended for error states
                label: 'Error!', // this is the header text
            });
        }else{
            this.resultValue = Math.sin(this.firstNumber);
            console.log(resultValue);
        }
       
    }
    sin30Method(){
      this.resultValue = Math.sin(30);
    }
    cos30Method(){
        this.resultValue = Math.cos(30);
    }
    tan30Method(){
        this.resultValue = Math.tan(30);
    }
    clearAll(){ 
        this.firstNumber = '';
        this.secondNumber = '';
        this.resultValue = '';
    }

}
import { LightningElement,api,track } from 'lwc';

export default class ParentComponent extends LightningElement {
    valueofInput = 0;

    handleonChange(event){
        this.valueofInput = parseInt(event.target.value);
        
    }
    onClickHandler(){
        // const updationOnChild = this.template.querySelector('c-child-component');
        // updationOnChild.add100value();
        this.valueofInput += 10;
    }

}
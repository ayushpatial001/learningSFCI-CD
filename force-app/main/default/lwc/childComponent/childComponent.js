import { LightningElement,api } from 'lwc';

export default class ChildComponent extends LightningElement {
  @api counter = 0;

  @api add100value(){
    this.counter += 10;
  }



}
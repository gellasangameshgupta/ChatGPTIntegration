import { LightningElement } from 'lwc';

export default class Checkbox extends LightningElement {
    areDetailsVisible =true; 
 handleChange(event) {
 this.areDetailsVisible = event.target.checked;
 }
}
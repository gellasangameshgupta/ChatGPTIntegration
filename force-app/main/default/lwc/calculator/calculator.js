import { LightningElement ,track } from 'lwc';

export default class Calculator extends LightningElement {
    @track Num1;
    @track Num2;
    @track resultValue;
    @track output = [];


    handleNumberOne(event) {
        this.Num1 = parseInt(event.target.value);
    }
    handleNumberTwo(event) {
        this.Num2 = parseInt(event.target.value);
    }
    add() {
        this.resultValue = parseInt(this.Num1) + parseInt(this.Num2);
        this.output.push('Result of' +' '+this.Num1+ ' + ' + this.Num2+' '+'is :'+this.resultValue);
        console.log(this.output);
    }
    sub() {
        this.resultValue =this.Num1 - this.Num2;
        this.output.push('Result of' +' '+this.Num1+ ' - ' + this.Num2+' '+'is :'+this.resultValue);
        console.log(this.output);
    }
    mul() {
        this.resultValue =this.Num1 * this.Num2;
        this.output.push('Result of' +' '+this.Num1+ ' * ' + this.Num2+' '+'is :'+this.resultValue);
        console.log(this.output);
    }
    div() {
        this.resultValue =this.Num1 / this.Num2;
        this.output.push('Result of' +' '+this.Num1+ ' / ' + this.Num2+' '+'is :'+this.resultValue);
        console.log(this.output);
    }


}
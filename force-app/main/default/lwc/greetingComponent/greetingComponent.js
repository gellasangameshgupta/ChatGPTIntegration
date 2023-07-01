import { LightningElement } from 'lwc';

export default class GreetingComponent extends LightningElement {

      greeting = "folks how are you?";

      handleChange(event){
            console.log(event.currentTarget.value);
            this.greeting = event.currentTarget.value;
      }

}
import { LightningElement, api } from 'lwc';

export default class CreateAccountForAccountWithContact extends LightningElement {
     fields = {};

    @api handleSubmit() {
        this.template.querySelector('lightning-record-edit-form').submit(this.fields);
    }

    handleNameChange(event) {
        this.fields.Name = event.target.value;
    }
    handlePhoneChange(event){
        this.fields.Phone = event.target.value;
    }
    handleEmailChange(event){
        this.fields.Email = event.target.value;
    }
    handleEmailChange(event){
        this.fields.Industry = event.target.value;
    }

    handleSucess(event) {
        const accountId = event.detail.id;
        const selectEvent = new CustomEvent('accountid', {
            detail: accountId
        });
        this.dispatchEvent(selectEvent);
    }
}
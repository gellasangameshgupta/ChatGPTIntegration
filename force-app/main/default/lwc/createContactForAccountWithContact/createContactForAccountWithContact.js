import { LightningElement,api } from 'lwc';

export default class CreateContactForAccountWithContact extends LightningElement {
    
    @api accountId;
    fields = {};

    @api handleSubmit() {
        this.fields.AccountId = this.accountId;
        this.template.querySelector('lightning-record-edit-form').submit(this.fields);
    }

    handleSucess(event) {
        const contactId = event.detail.id;
        const selectEvent = new CustomEvent('contactid', {
            detail: contactId
        });
        this.dispatchEvent(selectEvent);
    }

    firstNameChange(event) {
        this.fields.FirstName = event.target.value;
    }
    lastNameChange(event) {
        this.fields.LastName = event.target.value;
    }
    emailChange(event) {
        this.fields.Email = event.target.value;
    }
}
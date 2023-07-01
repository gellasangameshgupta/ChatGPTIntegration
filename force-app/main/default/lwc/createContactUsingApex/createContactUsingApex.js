import { LightningElement, wire, track,api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import createContact from '@salesforce/apex/CustomLookupLwcController.createContact';
import First_Name from '@salesforce/schema/Contact.FirstName';
import Last_Name from '@salesforce/schema/Contact.LastName';
import Email from '@salesforce/schema/Contact.Email';
import Phone from '@salesforce/schema/Contact.Phone';
import Mailing_Street  from '@salesforce/schema/Contact.MailingStreet';
import Mailing_City  from '@salesforce/schema/Contact.MailingCity';
import Mailing_State  from '@salesforce/schema/Contact.MailingState';
import Mailing_Country  from '@salesforce/schema/Contact.MailingCountry';
import Mailing_PostalCode  from '@salesforce/schema/Contact.MailingPostalCode';


export default class CreateContactUsingApex extends LightningElement {
    @track error;
    @track contactRecord = {
        FirstName : First_Name,
        LastName : Last_Name,
        Phone : Phone,
        Email : Email,
        MailingStreet : Mailing_Street,
        MailingCity : Mailing_City,
        MailingState : Mailing_State,
        MailingCountry : Mailing_Country,
        MailingPostalCode : Mailing_PostalCode,

    };
    handleFirstNameChange(event) {
        this.FirstName = event.target.value;
    }
    handleLastNameChange(event) {
        this.LastName = event.target.value;
    }
    handlePhoneChange(event) {
        this.Phone = event.target.value;
    }
    handleEmailChange(event) {
        this.Email = event.target.value;
    }
    handleMailingStreetChange(event) {
        this.MailingStreet = event.target.value;
    }
    handleMailingCityChange(event) {
        this.MailingCity = event.target.value;
    }
    handleMailingStateChange(event) {
        this.MailingState = event.target.value;
    }
    handleMailingCountryChange(event) {
        this.MailingCountry = event.target.value;
    }
    handleMailingPostalCodeChange(event) {
        this.MailingPostalCode = event.target.value;
    }
    handleSave() {
        createContact({contactRecord: this.contactRecord})
        .then(result => {
            // Clear the user enter values
            this.contactRecord = {};

            window.console.log('result ===> '+result);
            // Show success messsage
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success!!',
                message: 'Contact Created Successfully!!',
                variant: 'success'
            }),);
        })
        .catch(error => {
            this.error = error.message;
        });
    }


}
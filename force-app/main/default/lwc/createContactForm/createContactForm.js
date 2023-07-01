import { LightningElement,track, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
//import accountId from '@salesforce/schema/Contact.AccountId'
import First_Name from '@salesforce/schema/Contact.FirstName';
import Last_Name from '@salesforce/schema/Contact.LastName';
import Email from '@salesforce/schema/Contact.Email';
import Birthdate from '@salesforce/schema/Contact.Birthdate';
import Phone from '@salesforce/schema/Contact.Phone';
import Mailing_Street  from '@salesforce/schema/Contact.MailingStreet';
import Mailing_City  from '@salesforce/schema/Contact.MailingCity';
import Mailing_State  from '@salesforce/schema/Contact.MailingState';
import Mailing_Country  from '@salesforce/schema/Contact.MailingCountry';
import Mailing_ZipCode  from '@salesforce/schema/Contact.MailingPostalCode';

export default class CreateContactForm extends LightningElement {
    contactObject = CONTACT_OBJECT;
myFields = [First_Name,Last_Name,Email,Birthdate,Phone,Mailing_Street, Mailing_City,Mailing_State, Mailing_Country, Mailing_ZipCode];
    
    handleSubmit(event) {
    console.log(event.detail);
    }
    handleSuccess(event) {
    if(this.recordId !== null){
        this.dispatchEvent(new ShowToastEvent({
                title: "SUCCESS!",
                message: "Contact  has been created for this Account.",
               variant: "success",
            }),  
       );    
    }
   
    }

}
import { LightningElement,wire, api, track } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import fetchContactAndAccountRecords from '@salesforce/apex/CustomLookupLwcController.fetchContactAndAccountRecords';

export default class QuoteCreationWizardV2 extends LightningElement {

    @api recordId;
    contact = false;
    @track data = {};

    currentPageReference = null; 
 
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
        console.log('currentpagereference:'+JSON.stringify(currentPageReference));
        console.log('Id:'+JSON.stringify(currentPageReference.state.c__recordId));
        this.recordId = currentPageReference.state.c__recordId;
        console.log('RecordId:'+this.recordId);
       }
    }

    @wire(fetchContactAndAccountRecords, { contactId: '$recordId',})
    contacts({ error, data }) {
        if (data) {
            this.data = data;
            this.contact = true;
            console.log('contact:'+JSON.stringify(this.data));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        };
    }

}
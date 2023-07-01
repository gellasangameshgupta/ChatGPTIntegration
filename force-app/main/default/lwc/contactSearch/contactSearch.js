import { LightningElement,wire} from 'lwc';
import findContacts from '@salesforce/apex/lwcContactSearchController.findContacts';



export default class ContactSearch extends LightningElement {
    searchKey = '';

    @wire(findContacts, { searchKey: '$searchKey' })
    contacts({ error, data }) {
        if (data) {
            this.record = data;
            console.log('Contact:::'+contacts);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
    }
    handleKeyChange(event) {
      
        const searchKey = event.target.value;
            this.searchKey = searchKey;
        
    }
    
}
import { LightningElement,wire } from 'lwc';
import findBikes from '@salesforce/apex/hubSearchController.findBikes';

export default class HubSearch extends LightningElement {

    searchKey;
    hubs;
    error;

    handleKeyChange(event) {
        this.searchKey = event.target.value;
    }

    handleSearch() {
        findBikes({ searchKey: this.searchKey })
            .then((result) => {
                this.hubs = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                this.hubs = undefined;
            });
    }
}
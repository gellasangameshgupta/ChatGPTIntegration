import { LightningElement } from 'lwc';
import findOpportunity from '@salesforce/apex/lwcOpportunitySearch.findOpportunity';

export default class OpportunitySearch extends LightningElement {

    searchKey;
    oppo;
    error;

    handleKeyChange(event) {
        this.searchKey = event.target.value;
    }

    handleSearch() {
        findOpportunity({ searchKey: this.searchKey })
            .then((result) => {
                this.oppo = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                this.oppo = undefined;
            });
    }
}
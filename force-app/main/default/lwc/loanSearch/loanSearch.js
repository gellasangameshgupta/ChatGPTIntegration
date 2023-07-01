import { LightningElement,wire} from 'lwc';
import findLoan from '@salesforce/apex/loanSearchController.findLoan';



export default class loanSearch extends LightningElement {
    searchKey = '';

    @wire(findLoan, { searchKey: '$searchKey' })
    loans__c;

    handleKeyChange(event) {
      
        const searchKey = event.target.value;
            this.searchKey = searchKey;
        
    }
    
}
/**
 * @description       : 
 * @author            : Sangamesh Gella - ABSYZ Software Consulting Private Limited
 * @group             : 
 * @last modified on  : 04-08-2023
 * @last modified by  : Sangamesh Gella - ABSYZ Software Consulting Private Limited
 * Modifications Log
 * Ver   Date         Author                                                        Modification
 * 1.0   04-08-2023   Sangamesh Gella - ABSYZ Software Consulting Private Limited   Initial Version
**/
import { LightningElement, track } from 'lwc';
import getResponse from '@salesforce/apex/ChatGPTRegExGeneratorHandler.getResponse';
import IMAGE from '@salesforce/resourceUrl/ChatBot';

export default class RegExGen extends LightningElement {

    @track searchResults = [];
    @track previousSearches = [];
    imageUrl = IMAGE;
    searchTerm = '';
    showSpinner = false;
    responseData;

    handleKeyDown(event) {
        if(event.key === 'Enter') {
            this.searchTerm = event.target.value;
            const previousSearch = this.searchTerm;
            console.log('PS1: ', previousSearch);
            this.previousSearches.push(previousSearch);
            console.log('PS: ', this.previousSearches);
            this.searchResults = [];
            this.showSpinner = true;

            getResponse({prompt: this.searchTerm})
            .then(result => {
                this.showSpinner = false;
                let response = result;
                console.log('Response is: ' + JSON.stringify(response));
                if(response.error) {
                    this.responseData = response.error.message;
                } else if (response) {
                    this.responseData = response;
                    //this.handlePreviousSearches();
                }
            }).catch(error => {
                this.showSpinner = false;
                this.responseData = error;
            })
        }
    }

    handlePreviousSearches() {
        this.previousSearches.push(this.searchTerm);
        console.log('PS: ', this.previousSearches);
    }
}
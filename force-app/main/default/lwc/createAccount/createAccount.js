import { LightningElement ,track,wire, api} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import Phone from '@salesforce/schema/Account.Phone';
import Industry from '@salesforce/schema/Account.Industry';
import BillingStreet from '@salesforce/schema/Account.BillingStreet';
import BillingCountry from '@salesforce/schema/Account.BillingCountry';
import BillingCity from '@salesforce/schema/Account.BillingCity';
import BillingState from '@salesforce/schema/Account.BillingState';
import Type from '@salesforce/schema/Account.Type';
import BillingPostalCode from '@salesforce/schema/Account.BillingPostalCode';



/**
 * Creates Account records.
 */
export default class AccountCreator extends LightningElement {
    @track typePicklist=[];
    @track industryPicklist=[];
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: Type})
    TypePicklistValues({ error, data }) {
        if (data) {
            this.typePicklist = data;
            console.log('typePicklist'+JSON.stringify(this.typePicklist));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.typePicklist = undefined;
        }
    }
    


    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: Industry})
    IndustryPicklistValues({ error, data }) {
        if (data) {
            this.industryPicklist = data;
            console.log('industryPicklist'+JSON.stringify(this.industryPicklist));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.industryPicklist = undefined;
        }
    }

     @track accountRecord = {
        Name : undefined,
        Phone : undefined,        
        Industry : undefined,
        Type : undefined,
        BillingStreet : undefined,
        BillingCountry : undefined,
        BillingCity : undefined,
        BillingState : undefined,
        BillingPostalCode : undefined

    }
    handleNameChange(event) {
        this.accountRecord.Name = event.target.value;
    }
    handleAccountPhoneChange(event) {
        this.accountRecord.Phone = event.target.value;
    }
    handleIndustryChange(event) {
        this.accountRecord.Industry = event.target.value;
    }
    handleTypeChange(event) {
        this.accountRecord.Type = event.target.value;
    }
    handleBillingStreetChange(event) {
        this.accountRecord.BillingStreet = event.target.value;
    }
    handleBillingCityChange(event) {
        this.accountRecord.BillingCity = event.target.value;
    }
    handleBillingStateChange(event) {
        this.accountRecord.BillingState = event.target.value;
    }
    handleBillingCountryChange(event) {
        this.accountRecord.BillingCountry = event.target.value;
    }
    handleBillingPostalCodeChange(event) {
        this.accountRecord.BillingPostalCode = event.target.value;
    }
       
    @api
    fetchNewAccountDetails(){
        return this.accountRecord;
    }
}
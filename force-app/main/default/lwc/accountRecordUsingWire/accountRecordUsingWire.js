import {LightningElement,api,wire} from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';

import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCOUNT_INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ACCOUNT_BILLING_ADDRESS_FIELD from '@salesforce/schema/Account.BillingAddress';
import ACCOUNT_ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';   

const FIELDS = [ACCOUNT_NAME_FIELD, ACCOUNT_PHONE_FIELD, ACCOUNT_INDUSTRY_FIELD, ACCOUNT_BILLING_ADDRESS_FIELD, ACCOUNT_ANNUAL_REVENUE_FIELD];

export default class AccountRecordUsingWire extends LightningElement {

    @api recordId;

    @wire (getRecord, { recordId:'0015g000006LOssAAG', fields: FIELDS })
     account;

    get name(){
       
        return this.account.data && this.account.data.fields.Name.value;
        
    }
 
    get phone(){
        if(this.account.data){
        return this.account.data.fields.Phone.value;
        }
        
    }

    get industryType(){
        if(this.account.data){
        return this.account.data.fields.Industry.value;
        }
        
    }

    get billingAddress(){
        if(this.account.data){
        return this.account.data.fields.BillingAddress.value;
        }
        
    }

    get annualRevenue(){
        if(this.account.data){
        return this.account.data.fields.AnnualRevenue.value;
        }
        
    }


}
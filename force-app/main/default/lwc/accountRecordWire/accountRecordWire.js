import { LightningElement,api,wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCOUNT_TYPE_FIELD from '@salesforce/schema/Account.Type';
import ACCOUNT_INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ACCOUNT_BILLING_STREET_FIELD from '@salesforce/schema/Account.BillingStreet';
import ACCOUNT_BILLING_CITY_FIELD from '@salesforce/schema/Account.BillingCity';
//import ACCOUNT_BILLING_ZIP_FIELD from '@salesforce/schema/Account.BillingZipPostalCode';
//import ACCOUNT_BILLING_STATE_FIELD from '@salesforce/schema/Account.BillingStateProvince';
import ACCOUNT_BILLING_COUNTRY_FIELD from '@salesforce/schema/Account.BillingCountry';
//import ACCOUNT_BILLING_ADDRESS_FIELD from '@salesforce/schema/Account.BillingAddress';
import ACCOUNT_ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';

const FIELDS = [ACCOUNT_NAME_FIELD,ACCOUNT_PHONE_FIELD,ACCOUNT_TYPE_FIELD,
    ACCOUNT_INDUSTRY_FIELD,ACCOUNT_BILLING_STREET_FIELD,ACCOUNT_BILLING_CITY_FIELD,
ACCOUNT_BILLING_COUNTRY_FIELD,ACCOUNT_ANNUAL_REVENUE_FIELD];



export default class AccountRecordWire extends LightningElement {

    @api  recordId;
    @wire(getRecord, { recordId: '$recordId',fields :FIELDS}) record;
  
    get accountName(){
        if(this.record.data){
            console.log( this.record.data.fields.Name.value);
          return this.record.data.fields.Name.value;
    }}
  
    get phone(){
      if(this.record.data){
          return this.record.data.fields.Phone.value;
  }}
  
  get type(){
      if(this.record.data){
          return this.record.data.fields.Type.value;
  }}
  
  get industry(){
      if(this.record.data){
      return this.record.data.fields.Industry.value;
  }}
  
  get billingStreet(){
      if(this.record.data){
          return this.record.data.fields.BillingStreet.value;
  }}
  
  get billingCity(){
      if(this.record.data){
          return this.record.data.fields.BillingCity.value;
  }}
  
 
  
  get billingCountry(){
      if(this.record.data){
          return this.record.data.fields.BillingCountry.value;
  }}
  
  get annualRevenue(){
      if(this.record.data){
          return this.record.data.fields.AnnualRevenue.value;
  }}

}
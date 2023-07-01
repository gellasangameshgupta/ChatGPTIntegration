import { LightningElement, api, track,wire } from 'lwc';
import fetchAccountRecord from '@salesforce/apex/CustomLookupLwcController.fetchAccountRecord';

export default class QcwShowAccountDetails extends LightningElement {
    @api contactId;
    @wire (fetchAccountRecord,{contactId : $contactId}) 
    wiredAccounts({data,error}){
        if (data) {
        console.log(data); 
        } else if (error) {
        console.log(error);
        }
   }
  
}
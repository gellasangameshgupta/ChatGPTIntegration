import { LightningElement, track, wire } from 'lwc';
import getAccountRecords from '@salesforce/apex/AccountRecordController.getAccountRecords';
const columns = [
    { label: 'Name', fieldName: 'Name', editable: false, displayReadOnlyIcon: true },
    { label: 'Account Number', fieldName: 'AccountNumber'},
    { label: 'Rating', fieldName: 'Rating'},
    { label: 'Phone', fieldName: 'Phone', editable: true,},
];

export default class AccountDatatable extends LightningElement {
   columns = columns;
   data = [];
    @wire(getAccountRecords)
    accounts(result){
        if(result.data){
          this.data = result.data;
          this.error = undefined;
       }
       else if(result.error){
         this.error = result.error;  
         this.data = undefined;
       }

   }
    
}
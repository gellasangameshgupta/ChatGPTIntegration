import { LightningElement,wire,track,api } from 'lwc';
import getContacts from '@salesforce/apex/customerPendingFare.getContacts';
//import { getRecord } from 'lightning/uiRecordApi';  

export default class OutstandingDues extends LightningElement {


    @api recordId;
   


    @wire(getContacts,{
    recordId:'$recordId'
    }) contacts;
    }
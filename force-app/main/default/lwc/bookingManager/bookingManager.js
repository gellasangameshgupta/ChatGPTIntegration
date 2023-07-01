import { LightningElement,track, wire, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Booking_OBJECT from '@salesforce/schema/Booking__c';
import bike from '@salesforce/schema/Booking__c.Bike__c'
import customer from '@salesforce/schema/Booking__c.Customer__c';
import recordType from '@salesforce/schema/Booking__c.RecordTypeId';
import RideStartTime from '@salesforce/schema/Booking__c.Ride_Start_Time__c';
import startHub from '@salesforce/schema/Booking__c.Start_Hub__c';
import startLocation from '@salesforce/schema/Booking__c.Start_Location__c';

export default class bookingManager extends LightningElement {
    bookingObject = Booking_OBJECT;
    myFields = [bike,customer,recordType,RideStartTime,startHub,startLocation];
    handleSubmit(event) {
    console.log(event.detail);
    }
    handleSuccess(event) {
    if(this.recordId !== null){
        this.dispatchEvent(new ShowToastEvent({
                title: "SUCCESS!",
                message: "Booking  has been done.",
               variant: "success",
            }),  
       );    
    }
   
    }

}
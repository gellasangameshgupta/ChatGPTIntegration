import { LightningElement,api,wire } from 'lwc';
import inactiveBikes from '@salesforce/apex/countBike.inactiveBikes';
import bookedBikes from '@salesforce/apex/countBike.bookedBikes';
import dueToServiceBikes from '@salesforce/apex/countBike.dueToServiceBikes';


export default class HubStatus extends LightningElement {

    @api recordId;

    @wire(inactiveBikes,{
        recordId:'$recordId'
        }) inactiveBike;

    
    @wire(bookedBikes,{
        recordId:'$recordId'
         }) bookedBike;
    
    @wire(dueToServiceBikes,{
         recordId:'$recordId'
         }) serviceBike;
        

}
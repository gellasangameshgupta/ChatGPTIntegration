import { LightningElement , wire, api} from 'lwc';
import getOpportunity from '@salesforce/apex/CustomLookupSearchController.getOpportunity';
const columns = [
    { label: 'Name', fieldName: 'Name'},
    { label: 'Stage', fieldName: 'StageName'},
    { label: 'Close Date', fieldName: 'CloseDate'},
    { label: 'Amount', fieldName: 'Amount'},
];

export default class OpportunityDataTable extends LightningElement {
   columns = columns;
   @api accountId;
   data = [];
    @wire(getOpportunity, { accountId: '$accountId'})
    opportunity(result){
        if(result.data){
          this.data = result.data;
          this.error = undefined;
       }
       else if(result.error){
         this.error = result.error;  
         this.data = undefined;
       }

   }
   @api
    fetchOpportunityDetails(){
        return this.data;
    }
}
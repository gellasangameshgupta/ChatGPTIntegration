import { LightningElement,track,api,wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import Opportunity_OBJECT from '@salesforce/schema/Account';
import StageName from '@salesforce/schema/Opportunity.StageName';

export default class CreateOpportunity extends LightningElement {
    @track stagePicklist=[];
    @wire(getObjectInfo, { objectApiName: Opportunity_OBJECT })
    objectInfo;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: StageName})
    StagePicklistValues({ error, data }) {
        if (data) {
            this.stagePicklist = data;
            console.log('stagePicklist'+JSON.stringify(this.stagePicklist));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.stagePicklist = undefined;
        }
    }

     @track opportunityRecord = {
        Name : undefined,
        StageName : undefined,        
        AccountId : undefined,
        CloseDate : undefined
    }
    handleOpportunityNameChange(event) {
        this.opportunityRecord.Name = event.target.value;
    }
    handleOpportunityStageChange(event) {
        this.opportunityRecord.StageName = event.target.value;
    }
    handleOpportunityCloseDateChange(event) {
        this.opportunityRecord.CloseDate = event.target.value;
    }
    @api
    fetchNewOpportunityDetails(){
        return this.opportunityRecord;
    }
}
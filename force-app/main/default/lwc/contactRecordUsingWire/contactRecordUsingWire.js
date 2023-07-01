import { LightningElement,wire,api} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE_FIELD from '@salesforce/schema/Account.Phone';
import ACCOUNT_INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import ACCOUNT_BILLING_ADDRESS from '@salesforce/schema/Account.BillingAddress';
import ACCOUNT_ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue'; 

export default class ContactRecordUsingWire extends LightningElement {


    @api recordId;
    result={}
    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD,ACCOUNT_PHONE_FIELD,ACCOUNT_INDUSTRY_FIELD,ACCOUNT_BILLING_ADDRESS,ACCOUNT_ANNUAL_REVENUE_FIELD] })
    wiredRecord({data,error}){
        if(data){
            const {fields}= data
            Object.key(fields).forEach(item=>{
                let value = fields[item] && fields[item].displayValue ? fields[item].displayValue : fields[item].value
                this.result={...this.result, [item]:value}

            })
            console.log(JSON.stringify(data))
        }
        if(error){
            console.error(error)
        }
    }




}
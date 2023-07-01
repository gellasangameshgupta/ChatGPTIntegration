import {LightningElement,track,wire,api} from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import createContact from '@salesforce/apex/CustomLookupLwcController.createContact';
import createAccount from '@salesforce/apex/CustomLookupLwcController.createAccount';
import createOpportunity from '@salesforce/apex/CustomLookupLwcController.createOpportunity';
import createQuote from '@salesforce/apex/CustomLookupLwcController.createQuote';
// import First_Name from '@salesforce/schema/Contact.FirstName';
// import Last_Name from '@salesforce/schema/Contact.LastName';
// import Email from '@salesforce/schema/Contact.Email';
// import Phone from '@salesforce/schema/Contact.Phone';
// import Mailing_Street from '@salesforce/schema/Contact.MailingStreet';
// import Mailing_City from '@salesforce/schema/Contact.MailingCity';
// import Mailing_State from '@salesforce/schema/Contact.MailingState';
// import Mailing_Country from '@salesforce/schema/Contact.MailingCountry';
// import Mailing_PostalCode from '@salesforce/schema/Contact.MailingPostalCode';
// import AccountId from '@salesforce/schema/Contact.AccountId';
import getOpportunity from '@salesforce/apex/CustomLookupSearchController.getOpportunity';
import { CurrentPageReference } from 'lightning/navigation';
import fetchContactAndAccountRecords from '@salesforce/apex/CustomLookupLwcController.fetchContactAndAccountRecords';
import hasPermission from '@salesforce/customPermission/Can_Create_Orders_in_Quote_Wizard';


const columns = [{
        label: 'Name',
        fieldName: 'Name'
    },
    {
        label: 'Stage',
        fieldName: 'StageName'
    },
    {
        label: 'Close Date',
        fieldName: 'CloseDate'
    },
    {
        label: 'Amount',
        fieldName: 'Amount'
    },
];


export default class QuoteCreationWizard extends NavigationMixin(LightningElement) {

    @api recordId;
    @track contactId;
    @track accountId;
    @track opportunityId;
    @track quoteId;
    @track currentStep = "1";
    @track data = {};
    contact = false;
    areDetailsVisible = false;
    opportunity = false;
    @track error;
    @track contactRecord = {
        FirstName: undefined,
        LastName: undefined,
        Phone: undefined,
        Email: undefined,
        MailingStreet: undefined,
        MailingCity: undefined,
        MailingState: undefined,
        MailingCountry: undefined,
        MailingPostalCode: undefined,
        AccountId: undefined,
    };
    @track opportunityRecord = {
        Name: undefined,
        StageName: undefined,
        CloseDate: undefined,

    };
    @track accountRecord = {
        Name: undefined,
        Phone: undefined,
        Industry: undefined,
        AccountNumber: undefined,
        Type: undefined,
        BillingStreet: undefined,
        BillingCountry: undefined,
        BillingCity: undefined,
        BillingState: undefined,
        BillingPostalCode: undefined,
        Owner: undefined
    }

    handleOnStepClick(event) {
        this.currentStep = event.target.value;
    }
    
    // permission set validation
    get isSetupEnabled() {
        console.log('permissiom:'+hasPermission);
        return hasPermission;
    }

    get isStepOne() {
        return this.currentStep === "1";
    }

    get isStepTwo() {
        return this.currentStep === "2";
    }

    get isStepThree() {
        return this.currentStep === "3";
    }

   /* get isStepFour() {
        return this.currentStep === "4";
    } */

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
       if (currentPageReference) {
        console.log('currentpagereference:'+JSON.stringify(currentPageReference));
        console.log('Id:'+JSON.stringify(currentPageReference.state.c__recordId));
        this.recordId = currentPageReference.state.c__recordId;
        this.contactId = currentPageReference.state.c__recordId;
        console.log('RecordId:'+this.recordId);
       }
    }

    @wire(fetchContactAndAccountRecords, { contactId: '$recordId',})
    contacts({ error, data }) {
        if (data) {
            this.data = data;
            this.contact = true;
            this.accountId = data.AccountId;
            console.log(this.accountId);
            console.log('contact:'+JSON.stringify(this.data));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        };
    }


    value = '';
    newContact = false;
    existingConatct = false;
    OnEevntChange(Event) {
        this.value = Event.detail.value;
        if (this.value == 'ExistingContact') {
            this.existingConatct = true;
            this.newContact = false;
            console.log('existingConatct:' + this.existingConatct);
        } else {
            this.newContact = true;
            this.existingConatct = false;
        }
        console.log('Value++=' + this.value);
    }
    newAccount = false;
    existingAccount = false;
    OnEevntChange2(Event) {
        this.value = Event.detail.value;
        if (this.value == 'ExistingAccount') {
            this.existingAccount = true;
            this.newAccount = false;
            console.log('existingConatct:' + this.existingConatct);
        } else {
            this.newAccount = true;
            this.existingAccount = false;
        }
        console.log('Value++=' + this.value);
    }

    get options() {
        return [{
                label: 'Existing Contact',
                value: 'ExistingContact'
            },
            {
                label: 'New Contact',
                value: 'NewContact'
            },
        ];
    }
    get chooseContact() {
        return [{
                label: 'Existing Account',
                value: 'ExistingAccount'
            },
            {
                label: 'New Account',
                value: 'NewAccount'
            },
        ];
    }
    lookupRecord(event) {
        // alert('Selected Record Value on Parent Component is ' +  JSON.stringify(event.detail.selectedRecord));
        if (event.detail.selectedRecord !== undefined) {
            this.data = event.detail.selectedRecord;
            this.contactId = this.data.Id;
            this.contactRecord.AccountId = this.data.Id;
            this.accountId = this.data.AccountId;
            this.areDetailsVisible = true;
            console.log('selectedRecordOnParent::' + this.data.Id);
        } else {
            this.areDetailsVisible = false;
        }
    }

    // Opportunity detatable based on selected account
    columns = columns;
    showOpportunity = false;
    newOpportunity = false;
    opportunitydata = [];
    @wire(getOpportunity, {
        accountId: '$accountId'
    })
    opportunity(result) {
        if (result.data) {
            this.opportunitydata = result.data;
            this.opportunity = true;
            console.log('Opportunity:' + this.opportunitydata);
            if (this.opportunitydata !== null && this.opportunitydata.length > 0) {
                this.showOpportunity = true;
            } else {
                this.newOpportunity = true;
            }

            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.opportunitydata = undefined;
        }

    }

    //Next button option
    handleNext() {
        if(this.currentStep === "1" && this.contact === true){
            this.currentStep = "2";
        }
        else if (this.currentStep === '1' && this.existingConatct === true) {
            this.currentStep = "2";
        } 
        else if (this.currentStep == "1" && this.existingAccount == true) {
            this.currentStep = "2";
            console.log(JSON.stringify(this.contactRecord));
            createContact({
                    contactRecord: this.contactRecord
                })
                .then(result => {
                    this.contactId = result.Id;
                    window.console.log('result ===> ' + this.contactId);
                    this.accountId = this.data.Id;
                    this.contactRecord.FirstName = result.FirstName;
                    this.contactRecord.LastName = result.LastName;
                    this.contactRecord.Phone = result.Phone;
                    this.contactRecord.Email = result.Email;
                })
                .catch(error => {
                    this.error = error.message;
                });

        } else if (this.currentStep == "1" && this.newAccount == true) {
            this.currentStep = "2";
            var accountRecord = this.template.querySelector('c-create-account').fetchNewAccountDetails();
            console.log('accountRecord:' + JSON.stringify(accountRecord));
            createAccount({
                    accountRecord: accountRecord
                })
                .then(result => {
                    this.accountId = result.Id;
                    window.console.log('accountResult ===> ' + this.accountId);
                    console.log('AccountOwner:' + JSON.stringify(result));
                    this.contactRecord.AccountId = this.accountId;
                    console.log('contactRecord.AccountId' + this.contactRecord.AccountId);
                    this.accountRecord.Name = result.Name;
                    this.accountRecord.AccountNumber = result.AccountNumber;
                    this.accountRecord.Industry = result.Industry;
                    this.accountRecord.Owner = result.Owner.Name;


                    createContact({
                            contactRecord: this.contactRecord
                        })
                        .then(result => {
                            this.contactId = result.Id;
                            window.console.log('ContactResult ===> ' + this.contactId);
                        })
                        .catch(error => {
                            this.error = error.message;
                        });


                })
                .catch(error => {
                    this.error = error.message;
                });


        } else if (this.currentStep = "2" && this.newOpportunity == true) {

            var opportunityRecord = this.template.querySelector('c-create-opportunity').fetchNewOpportunityDetails();
            opportunityRecord.AccountId = this.accountId;
            console.log('opportunityRecord:' + JSON.stringify(opportunityRecord));
            createOpportunity({
                    opportunityRecord: opportunityRecord
                })
                .then(result => {
                    this.opportunityId = result.Id;
                    this.opportunityRecord.Name = result.Name;
                    this.opportunityRecord.StageName = result.StageName;
                    this.opportunityRecord.CloseDate = result.CloseDate;
                    window.console.log('OpportunityId ===> ' + this.opportunityId);
                })
                .catch(error => {
                    this.error = error.message;
                });

            this.currentStep = "3";
        } else if (this.currentStep = "2" && this.showOpportunity == true) {
            var singleOpportunity = this.template.querySelector('lightning-datatable').getSelectedRows();
            this.opportunityRecord.Name = singleOpportunity[0].Name;
            console.log('opportunity name:' + this.opportunityRecord.Name);
            this.opportunityRecord.StageName = singleOpportunity[0].StageName;
            this.opportunityRecord.CloseDate = singleOpportunity[0].CloseDate;
            this.opportunityId = singleOpportunity[0].Id;
            console.log('singleOpportunity' + JSON.stringify(singleOpportunity));
            console.log('opportunityReord:' + JSON.stringify(this.opportunityRecord));
            this.currentStep = "3";
        } else if(this.currentStep = "3"){
            this.currentStep = "4";
        }
    }
    handleBack() {
        if (this.currentStep == '2') {
            this.currentStep = '1';
        } else if (this.currentStep == '3') {
            this.currentStep = '2';
        }
    }

    //Contact inputs handler
    handleFirstNameChange(event) {
        this.contactRecord.FirstName = event.target.value;
    }
    handleLastNameChange(event) {
        this.contactRecord.LastName = event.target.value;
    }
    handlePhoneChange(event) {
        this.contactRecord.Phone = event.target.value;
    }
    handleEmailChange(event) {
        this.contactRecord.Email = event.target.value;
    }
    handleMailingStreetChange(event) {
        this.contactRecord.MailingStreet = event.target.value;
    }
    handleMailingCityChange(event) {
        this.contactRecord.MailingCity = event.target.value;
    }
    handleMailingStateChange(event) {
        this.contactRecord.MailingState = event.target.value;
    }
    handleMailingCountryChange(event) {
        this.contactRecord.MailingCountry = event.target.value;
    }
    handleMailingPostalCodeChange(event) {
        this.contactRecord.MailingPostalCode = event.target.value;
    }


    handleCreateQuote() {
        createQuote({
                contactId: this.contactId,
                opportunityId: this.opportunityId
            })
            .then(result => {
                this.quoteId = result.Id;
                window.console.log('quoteId ===> ' + this.quoteId);
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: this.quoteId,
                        objectApiName: 'Quote',
                        actionName: 'view'
                    }
                });

            })
            .catch(error => {
                this.error = error.message;
            });


    }



}
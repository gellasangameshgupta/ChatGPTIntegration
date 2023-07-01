import BasePrechat from 'lightningsnapin/basePrechat';
import { api, wire, track } from 'lwc';
import getPreviousChat from '@salesforce/apex/PreChatController.getPreviousChat';



export default class PreChatWindow extends BasePrechat {

    //@api recordId;
    @api prechatFields;
    @api backgroundImgURL;
    @track fields;
    @track namelist;
    @track chats;
    @track error;
    @api VisitorId;

    @track columns = [{
        label: 'Previous Chat',
        fieldName: 'Body',
        type: 'text',
    }
    ];
    
    @wire (getPreviousChat)
       
        
    wiredChat({
        error,
        data
    }) {
        if (data) {
            this.chats = data;
        } else if (error) {
            this.error = error;
        }
    }

    
    /**
     * Set the button label and prepare the prechat fields to be shown in the form.
     
    connectedCallback() {
        this.startChatLabel = startChatLabel;
        this.fields = this.prechatFields.map(field => {
            const { label, name, value, required, maxLength } = field;

            return { label, value, name, required, maxLength };
        });
        this.namelist = this.fields.map(field => field.name);
    }
    /**
     * Focus on the first input after this component renders.
     
    renderedCallback() {
        this.template.querySelector("lightning-input").focus();
    }
   

    /* getting previous chat from Apex Class */
  
    

    

     /**
     * On clicking the 'Start Chatting' button, send a chat request.
     
    handleStartChat() {
        this.template.querySelectorAll("lightning-input").forEach(input => {
            this.fields[this.namelist.indexOf(input.name)].value = input.value;
        });
        if (this.validateFields(this.fields).valid) {
            this.startChat(this.fields);
        } else {
            // Error handling if fields do not pass validation.
        }
    } */
}
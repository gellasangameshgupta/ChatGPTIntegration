import { LightningElement,track,api } from 'lwc';
import getResponse from '@salesforce/apex/ChatGPTController.getResponse';
import IMAGE from '@salesforce/resourceUrl/ChatBot';


export default class ChatGPT extends LightningElement {
  @track searchResults = [];
  searchTerm = '';
  imageUrl = IMAGE;
  showSpace = true ;
  showSpinner = false
  responseData;

  handleKeyDown(event) {
    
      if (event.key === 'Enter') {
        // Perform search when the Enter key is pressed
        this.searchTerm = event.target.value;
        this.showSpinner = true
        this.searchResults = [];
        getResponse({searchString:this.searchTerm})
         .then(result=>{
           this.showSpinner = false
           console.log('searchTerm:'+this.searchTerm);
           let response = JSON.parse(JSON.stringify(JSON.parse(result)));
           console.log('response:'+JSON.stringify(response));
           if (response.error) {
                    this.responseData = response.error.message;
            } else if (response.choices[0].text) {
                    this.responseData = response.choices[0].text;
                    this.responseData = this.responseData.replace(/\n/g, "<br />");
                    let tempScriptData = ''
                    tempScriptData = (response.choices[0].text.includes('<script>')) ? 'JS File: ' + response.choices[0].text.split('<script>')[1] : '';
                    tempScriptData = this.responseTextLWCJS.replace(/\n/g, "<br />");

                    this.responseData = this.responseData + this.responseTextLWCJS;
                    this.responseData = (this.responseData.includes('XML File:')) ? this.responseData.split('XML File:')[0] : this.responseData;

                    this.responseData.trim();
            }
           console.log('ss',JSON.stringify(responseData))
         })
         .catch(error=>{
           this.showSpinner = false
           console.log('error is '+JSON.stringify(this.error));
         })
    // Replace with a call to your search service
        if(this.searchResults.length > 0 )
          this.showSpace =false
      }
    
  }
}
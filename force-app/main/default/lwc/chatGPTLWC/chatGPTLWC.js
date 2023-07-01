import { LightningElement, track, api } from 'lwc';
import getChatResponse from '@salesforce/apex/MyChatController.getChatResponse';
import CHAT_BOT_IMAGE from '@salesforce/resourceUrl/ChatBot';

export default class chatGPTLWC extends LightningElement {
  @track searchResults = [];
  searchTerm = '';
  chatBotImageUrl = CHAT_BOT_IMAGE;
  showChatHistory = true;
  showSpinner = false;
  responseData;

  handleKeyDown(event) {
    if (event.key === 'Enter') {
      this.searchTerm = event.target.value;
      this.showSpinner = true;
      this.searchResults = [];
      
      getChatResponse({ query: this.searchTerm })
        .then(response => {
          this.showSpinner = false;
          this.responseData = response;
          console.log('Response:', JSON.stringify(response));

          if (this.responseData.includes('<script>')) {
            let tempScriptData = 'JS File: ' + this.responseData.split('<script>')[1];
            this.responseData = this.responseData.replace('<script>' + tempScriptData, '');
            this.responseData += '<br />' + tempScriptData;
          }

          this.responseData = this.responseData.replace(/\n/g, '<br />');
          this.responseData = this.responseData.split('XML File:')[0].trim();
          console.log('Response Data:', this.responseData);

          this.showChatHistory = false;
        })
        .catch(error => {
          this.showSpinner = false;
          console.error('Error:', error);
        });
    }
  }
}
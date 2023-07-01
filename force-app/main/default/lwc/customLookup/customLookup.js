import { LightningElement,api,wire} from 'lwc';
import fetchRecord from '@salesforce/apex/CustomLookupSearchController.fetchRecord';
const DELAY = 300;
export default class customLookup extends LightningElement {
   
    @api sObjectApiName = 'Contact';  
    searchKey=''; 
    error;
    data=[];  
  
    // wire function property to fetch search record based on user input
    @wire(fetchRecord, { searchKey: '$searchKey' , sObjectApiName : '$sObjectApiName' })
    contacts({data, error}){
        if(data){
            console.log('data:::'+JSON.stringify(data));
            this.error = undefined;
        }
        else{
            this.data = undefined;
            this.error = error;
            console.error(JSON.stringify(error));
        }
    }
    
     
    
       
    handleKeyChange(event) {
      
        const searchKey = event.target.value;
            this.searchKey = searchKey;
        
    }


}
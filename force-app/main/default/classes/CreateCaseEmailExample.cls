global class CreateCaseEmailExample implements Messaging.InboundEmailHandler {
 
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
 
    // Create an InboundEmailResult object for returning the result of the 
    // Apex Email Service
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  
    String myPlainText= '';
    
    // Add the email plain text into the local variable 
    myPlainText = email.plainTextBody;
       system.debug('myPlainText:'+myPlainText);  
     String text =   myPlainText.replace('\n','');                                                    
     
     String CHAT_GPT_KEY = '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'; // replace with the key
     String ENDPOINT ='https://api.openai.com/v1/completions';                                                       
                                                           
   
    try {
        
            String responseBody = '';
            String seachQueryEscaped = 'extract all the fields with fields value from given body to create a case in salesforce '+text.trim();
            Http http = new Http();
            String reqBody = '{"model": "text-davinci-003","prompt":"'
                +seachQueryEscaped+
                '","max_tokens": 4000,"temperature": 0,'
                +'"stream": false,"top_p": 0.5}';
            System.debug('Query '+seachQueryEscaped+' '+reqBody);
            String requestBody = reqBody;
            HttpRequest request = new HttpRequest();
            request.setEndpoint(ENDPOINT);
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer '+String.escapeSingleQuotes(CHAT_GPT_KEY).trim());
            //Setting timeout to max 120 second to get whole response from Chat GPT Open API
            request.setTimeout(120000);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            // Set the body as a JSON object
            request.setBody(requestBody);
            HttpResponse response = http.send(request);
           system.debug('response:'+response.getBody());
            // Parse the JSON response
            if(response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getBody());
               responseBody = response.getBody();
            }
     
      
    }
    // If an exception occurs when the query accesses 
    // the contact record, a QueryException is called.
    // The exception is written to the Apex debug log.
   catch (QueryException e) {
       System.debug('Query Issue: ' + e);
   }
   
   // Set the result to true. No need to send an email back to the user 
   // with an error message
   result.success = true;
   
   // Return the result for the Apex Email Service
   return result;
  }
}
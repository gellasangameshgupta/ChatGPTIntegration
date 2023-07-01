/**
 * @description       : 
 * @author            : Sangamesh Gella - ABSYZ Software Consulting Private Limited
 * @group             : 
 * @last modified on  : 06-29-2023
 * @last modified by  : Sangamesh Gella - ABSYZ Software Consulting Private Limited 
 * Modifications Log
 * Ver   Date         Author                                                        Modification
 * 1.0   06-29-2023   Sangamesh Gella - ABSYZ Software Consulting Private Limited   Initial Version
**/
public with sharing class ChatGPTController{
    private static String CHAT_GPT_KEY = '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';
    private static final String ENDPOINT ='https://api.openai.com/v1/completions';
    
    @AuraEnabled
    public static String getResponse(String searchString){
        try{
            String searchQueryEscaped = (searchString).trim();
            Http http = new Http();
            String reqBody = '{"model": "text-davinci-003","prompt":"'
                +searchQueryEscaped+
                '","max_tokens": 4000,"temperature": 0,'
                +'"stream": false,"top_p": 1}';
            System.debug('Query '+searchQueryEscaped+' '+reqBody);
            HttpRequest request = new HttpRequest();
            request.setEndpoint(ENDPOINT);
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer '+String.escapeSingleQuotes(CHAT_GPT_KEY).trim());
            //Setting timeout to max 120 second to get whole response from Chat GPT Open API
            request.setTimeout(120000);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
           // request.setHeader('Content-Type', 'application/json');
            // Set the body as a JSON object
          //  request.setBody(JSON.serialize(reqBody));
            request.setBody(reqBody);
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if(response.getStatusCode() != 200) {
                System.debug('Error: ' + response.getStatusCode() + ' ' + response.getBody());
                return response.getBody();
            }
            return response.getBody();
        }catch(Exception ex){
            System.debug('Error '+ex);
            throw new AuraHandledException(ex.getMessage());
        }
    }
}
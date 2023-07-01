/**
 * @description       : 
 * @author            : Sangamesh Gella - ABSYZ Software Consulting Private Limited
 * @group             : 
 * @last modified on  : 04-11-2023
 * @last modified by  : Sangamesh Gella - ABSYZ Software Consulting Private Limited
 * Modifications Log
 * Ver   Date         Author                                                        Modification
 * 1.0   04-08-2023   Sangamesh Gella - ABSYZ Software Consulting Private Limited   Initial Version
**/
public with sharing class ChatGPTRegExGeneratorHandler {
    private static String CHAT_GPT_KEY = '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';
    private static final String ENDPOINT ='https://api.openai.com/v1/completions';

    @AuraEnabled
    public static String getResponse(String prompt) {
        try {

            String userSearch = 'Write me a JavaScript regular expression ' + prompt + ' as a literal without a variable declaration';
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('model', 'text-davinci-003');
            gen.writeStringField('prompt', userSearch);
            gen.writeNumberField('temperature', 0);
            gen.writeEndObject();

            String jsonGen = gen.getAsString();
            System.debug('Request body is: ' + jsonGen);
            Http http = new Http();

            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint(ENDPOINT);
            httpRequest.setMethod('POST');
            httpRequest.setHeader('Authorization', 'Bearer '+String.escapeSingleQuotes(CHAT_GPT_KEY).trim());
            httpRequest.setTimeout(120000);
            httpRequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
            httpRequest.setBody(jsonGen);

            HttpResponse httpResponse = http.send(httpRequest);
            JSON2ApexChatGPTRegex response = (JSON2ApexChatGPTRegex) JSON.deserialize(httpResponse.getBody(), JSON2ApexChatGPTRegex.Class);

            String gptPrompt = response.choices[0].text;
            System.debug('Content is: ' + gptPrompt);

            if(httpResponse.getStatusCode() != 200) {
                System.debug('Error: ' + httpResponse.getStatusCode() + ' ' + httpResponse.getBody());
                return httpResponse.getBody();
            }
            return gptPrompt;
        } catch(Exception ex){
            System.debug('Error '+ ex);
            throw new AuraHandledException(ex.getMessage());
        }
    }
}
public class MyChatController {

    @AuraEnabled
    public static String getChatResponse(String query){

        String endpoint = 'https://api.openai.com/v1/completions';
        String key = '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'; // <-- Replace with your actual OpenAI API key

        try{
            String searchQuery = query.trim();
            String reqBody = '{"model": "text-davinci-003","prompt":"'
                +searchQuery+
                '","max_tokens": 4000,"temperature": 0,'
                +'"stream": false,"top_p": 0.5}';
            Http http = new Http();
            String requestBody = reqBody;
            HttpRequest request = new HttpRequest(); 
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setHeader('Authorization', 'Bearer ' + key); // <-- Set the authorization header
            request.setEndpoint(endpoint);
            request.setMethod('POST');
            request.setBody(requestBody);
            
            HttpResponse response = http.send(request);
            
            // Parse the JSON response
            if(response.getStatusCode() != 200) {
                System.debug('Response Error:' + response.getStatusCode() + ' ' + response.getBody());
                return response.getBody();
            }
            
            return response.getBody();
            
        } catch(Exception ex){
            System.debug('Exception log:'+ ex.getMessage());
            throw new AuraHandledException(ex.getMessage());
        }
    }
}
public with sharing class PreChatController {
   
    @AuraEnabled(cacheable=true)
    public static List<LiveChatTranscript> getPreviousChat(){

        List<LiveChatTranscript>  chat = [SELECT id, body from LiveChatTranscript order by CreatedDate limit 2];

        
        return chat;
    }

   
  
}
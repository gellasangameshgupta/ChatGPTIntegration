public without sharing class hubDetailTableController {

    
    @AuraEnabled
    public static List<Hub__c> getHubRecord()
   {
       system.debug([Select Name,Active__c,Location__latitude__s, Location__longitude__s,Rating__c from Hub__c limit 5]);
        return [Select Name,Active__c,Location__latitude__s, Location__longitude__s,Rating__c,Colour__c from Hub__c limit 5];

    }
   


}
public with sharing class hubSearchController {
   
    @AuraEnabled(cacheable=true)
    public static List<Hub__c> findBikes(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id, Name,(Select id,name,Vehicle_No__c,Is_Booked__c,KM_Covered__c from Bikes__r)
            FROM Hub__c
            WHERE Name LIKE :key 
            LIMIT 10
        ];
    }
}
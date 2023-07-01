public with sharing class CustomLookupSearchController {
   // Method to fetch lookup search result   
   @AuraEnabled(cacheable=true)
   public static list<sObject> fetchRecord(string searchKey , string sObjectApiName) {    
       List < sObject > returnList = new List < sObject > ();
       string key = '%' + searchKey + '%';
       string sQuery = 'Select Id,firstname,lastname From ' + sObjectApiName + ' Where Name Like : key  LIMIT 10';
       List<Sobject> sObjectList = database.query(sQuery);
       for (sObject obj: sObjectList) {
           returnList.add(obj);
       }
       return returnList;
   }
   @AuraEnabled(cacheable = true)
   Public static List<Account> fetchAccountRecord(String contactId){
       Set<Id> accountId = new Set<Id>();
       for( Contact contactList : [Select Id, accountId from contact where Id =: contactId]){
           if(contactList.accountId != null){
            accountId.add(contactList.accountId);
           }

       }
       List<Account> accountList = [select Id,name, AccountNumber,Owner.Name, Industry from Account where id IN : accountId];
       return accountList;

   }
   @AuraEnabled(cacheable = true)
   Public static List<Opportunity> getOpportunity(String accountId){
       List<Opportunity> opportunityList = [Select Id, name, StageName, CloseDate, Amount from Opportunity where AccountId =:accountId];
       return opportunityList;
   }
   
  
}
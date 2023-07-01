public with sharing class AccountRecordController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountRecords(){
       return new List<Account>([Select Id, name, AccountNumber, rating, phone from Account where phone != null Limit 5]);
    }
}
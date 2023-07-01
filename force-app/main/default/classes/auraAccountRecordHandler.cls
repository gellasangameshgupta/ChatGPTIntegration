public with sharing class auraAccountRecordHandler {
   
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountRecord() {
        return [SELECT name, phone, annualRevenue,website,type,rating,LastModifiedById FROM Account order by LastModifiedById desc limit 10];    }
}
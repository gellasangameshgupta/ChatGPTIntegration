public with sharing class customerPendingFare {
   
    @AuraEnabled(cacheable=true)
    public static Decimal getContacts(String recordId){
        List<Booking__c> lst = [SELECT id, Name,Paid__c,Actual_Fare__c from Booking__c where Paid__c=false and Customer__c=:recordId];
        decimal totalFare= 0;
         for(Booking__c BookingList:lst)
         {
             if(BookingList.Actual_Fare__c!=null)
             {
            totalFare=BookingList.Actual_Fare__c+totalFare;
             }
         }
         System.debug('total fare'+totalFare);
        return totalFare;
    }
}
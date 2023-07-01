Public class BounceCustomerBatch implements Database.Batchable<sObject> {
    
      Public Database.QueryLocator start(Database.BatchableContext bc)
      {
        return Database.getQueryLocator('select id,bike__c,customer__c,customer__r.MVP_C__c,bike__r.No_Of_Bookings__c,bike__r.KM_Covered__c from Booking__c where Booking_Time__c = LAST_N_DAYS:40 ');
              
      }
    
      Public void execute(Database.BatchableContext bc, List<Booking__c> scope)
      {
          Set<id> customerId = new Set<id>();
          List<Contact> contactList = new List<Contact>();
          
          
          for(Booking__c bookingHistory : scope)
          {
             if(bookingHistory.bike__r.KM_Covered__c > 75 && bookingHistory.bike__r.No_Of_Bookings__c > 5)  
             {
                //bookingHistory.Customer__c.MVP_C__c = true;
                customerId.add(bookingHistory.Customer__c);
                 
             }
          }
          for(Contact conRecord : [select id from contact where id=:customerId])
          {
              conRecord.MVP_C__c = true;
              contactList.add(conRecord);
          }
          if(contactList.size() > 0)
          {
              update contactList;
          }

        
      }
    
      Public void finish(Database.BatchableContext bc)
      {
         
      }
}
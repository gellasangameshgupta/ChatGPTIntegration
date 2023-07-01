public class InvoicePriorityApexBatch implements Database.Batchable<sObject> {
       public Database.QueryLocator start(Database.BatchableContext bc)
      {
        return Database.getQueryLocator('select id,name,priority__c from invoice__c');
              
      }
      public void execute(Database.BatchableContext bc, List<Invoice__c> scope){
         List<Invoice__c> invoiceList = new List<Invoice__c>();
         for(Invoice__c inv : scope)
         {
             if(inv.Invoice_Total__c >= 0 && inv.Invoice_Total__c <= 10000 )
             {
                 inv.Priority__c = 'Low';
                 invoiceList.add(inv);
             }
             else if(inv.Invoice_Total__c >= 10000 && inv.Invoice_Total__c <= 50000 )
             {
                 inv.Priority__c = 'Medium';
                 invoiceList.add(inv);
             }
             else if(inv.Invoice_Total__c > 50000 )
             {
                 inv.Priority__c = 'High';
                 invoiceList.add(inv);
             }
            
         }
         if(invoiceList.size() >0)
         {
            update invoiceList;
         }
         
               
      }
      public void finish(Database.BatchableContext bc)
     {
         
     }

}
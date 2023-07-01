public class LineItemsDeleteBatchClass implements Database.Batchable<sObject> {
    
     public Database.QueryLocator start(Database.BatchableContext bc)
      {
         // string pepejeans='pepe jeans' ;
          return Database.getQueryLocator('select id,name,(select id,name from Line_Items__r) from merchandise__c where name = \'pepe jeans\' ');
              
      }
      public void execute(Database.BatchableContext bc, List<Merchandise__c> scope)
      {
         List<Line_Item__c> deletelineItemList = new List<Line_Item__c>();
          
          For(Merchandise__c merchandiseRecord : scope )
          {
            
              if(MerchandiseRecord.line_Items__r.size() > 0)
              {
                  deletelineItemList.addall(MerchandiseRecord.Line_Items__r);
              }
       
          }
        
          if(deletelineItemList.size() > 0)
          {
              delete deletelineItemList;
          }
      }
      public void finish(Database.BatchableContext bc)
      {
         
      }

}
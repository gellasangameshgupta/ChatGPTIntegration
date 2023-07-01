public class LineItemRecordHandler {
    
      public static void countLineItemPerMerchandise(List<Line_Item__c> lineItemlist)
      {
        Set<Id> merchandiseId = new Set<Id>();
        if(lineItemlist.size() > 0)
        {
           for(Line_Item__c merchandisedRecords : lineItemlist )
           {
            merchandiseId.add(merchandisedRecords.merchandise__c);
           }
        }
        
        List<Merchandise__c> merchandiseList = new List<Merchandise__c>([select id,name,No_of_Line_Items__c, (select id,name from Line_Items__r)
                                                                 from Merchandise__c where id IN : merchandiseId ]);
        if(merchandiseList.size() > 0)
        {
            for(Merchandise__c merchandiseRecords : merchandiseList)
            {
                Integer lineItemSize = merchandiseRecords.line_Items__r.size();
                merchandiseRecords.No_of_Line_Items__c = lineItemSize;
                merchandiseList.add(merchandiseRecords);
            }
        }
        if(merchandiseList.size() > 0)
        {
            update merchandiseList;
        }
    }

}
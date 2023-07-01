public class LineItemUnitPriceHandler {
    
    public static void updateUnitPrice(List<Line_Item__c> lineItemUpdateList)
    {
        Set<id> merchandiseIdSet = new Set<id>();
        for(Merchandise__c merchandiseRecord :[select id,name from merchandise__c])
        {
            merchandiseIdSet.add(merchandiseRecord.Id);
        }
        
        List<Line_Item__c> lineItemList = new List<Line_Item__c>([select id,name,unit_Price__c,merchandise__r.quantity__c
                                                                   from Line_Item__c where merchandise__c IN : merchandiseIdSet]);
        for(Line_Item__c lineItemRecord : lineItemList)
        {
            if(lineItemRecord.Quantity__c == 20)
            {
                lineItemRecord.Unit_Price__c = lineItemRecord.Unit_Price__c * 2;
                lineItemUpdateList.add(lineItemRecord);
            }
        }
        if(lineItemUpdateList.size() > 0)
        {
            update lineItemUpdateList;
        }
        
    }

}
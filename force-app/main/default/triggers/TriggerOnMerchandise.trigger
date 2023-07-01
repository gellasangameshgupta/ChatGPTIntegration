trigger TriggerOnMerchandise on Merchandise__c (before insert,before update) {
    List<Line_Item__c> listLineItems =new List<Line_Item__c>();
    set<id> merchandiseId = new set<id>();
    for(Merchandise__c merchandiseRecord : trigger.new)
    {
        merchandiseId.add(merchandiseRecord.id);
        system.debug('merchandiseId==>'+merchandiseId);
    }
    List<Line_Item__c> listLineItemsRecord =new List<Line_Item__c>([select id,unit_Price__c,merchandise__r.quantity__c from line_Item__c where merchandise__c in :merchandiseId]);
    system.debug('listLineItemsRecord==>'+listLineItemsRecord);
    for(Line_Item__c lineRecords : listLineItemsRecord)
    {
        if(lineRecords.merchandise__r.quantity__c == 20)
        {
            lineRecords.Unit_Price__c = lineRecords.Unit_Price__c*2;
             listLineItems.add(lineRecords);
        }
    }
    system.debug('listLineItems==>'+listLineItems);
    if(listLineItems.size()>0){
            update listLineItems;
    }

  

}
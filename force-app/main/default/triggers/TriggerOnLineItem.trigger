trigger TriggerOnLineItem on Line_Item__c (before insert,before update,before delete) {
    Set <Id> merchandiseIds = new Set <Id>();
    List <merchandise__c> merchandiseList = new List <merchandise__c>();
    if(Trigger.isInsert){
    for(Line_Item__c lineItem:trigger.new){
        merchandiseIds.add(lineItem.merchandise__c);
    }
   }
    if(Trigger.isUpdate || Trigger.isDelete){
    for(Line_Item__c lineItem:trigger.old){
        merchandiseIds.add(lineItem.merchandise__c);
    }
 }

    List<Merchandise__c> mer = new List<Merchandise__c>([Select Id,No_of_Line_Items__c,(Select Id from Line_Items__r) from merchandise__c where Id IN: merchandiseIds]);
    for(Merchandise__c merch : mer ) {
        Integer sizeOfLineItems = merch.line_Items__r.size();
        if(sizeOfLineItems!=merch.No_of_Line_Items__c){
        merch.No_of_Line_Items__c = sizeOfLineItems;
        merchandiseList.add(merch);
        }
    }
  UPDATE merchandiseList;
}
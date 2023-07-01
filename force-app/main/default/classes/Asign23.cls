public class Asign23 {
    public void unitPriceUpdate(){
        Map<String,Integer> mapRecord=new Map<String,Integer>();
        List<Line_Item__c> listLineItem=[select id,name,unit_price__c,Merchandise__r.price__c from Line_Item__c];
        List<Merchandise__c> listMerchandise=[Select id,price__c,(select id,name,unit_price__c from line_items__r) from merchandise__c];
        for(Merchandise__c merchandise:listMerchandise)
        {
            mapRecord.put(merchandise.id,Merchandise.Line_Items__r.size());
        }
        for(Line_Item__c lineItems :listLineItem)
        {
            if(mapRecord.containsKey(lineItems.merchandise__c))
            {
                lineItems.Unit_Price__c=lineItems.merchandise__r.price__c/mapRecord.get(lineItems.merchandise__c);
                List<Line_Item__c> unitPrice=new List<Line_Item__c>();
              //  unitPrice.add(lineItems.Unit_Price__c);
            }
        }
    }
}
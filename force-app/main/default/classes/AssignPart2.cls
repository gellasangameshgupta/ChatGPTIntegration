public class AssignPart2 {
    public static map<merchandise__c, list<Line_Item__c>> display()
    {
       map<merchandise__c, list<Line_Item__c>> m1 = new map<merchandise__c, list<Line_Item__c>>();
        
        for(Merchandise__c m2 : [select id,name,(select Unit_Price__c from Line_Items__r) from Merchandise__c])
        {
           m1.put(m2, m2.Line_Items__r);
        }
        return m1;
    }
    
    public void updateValue()
    {
        
        list<  invoice__C> listToUpdate= new  list<  invoice__C>();                 
       //If we have the Rollupsummary
        for(invoice__C invoiceRecord :[select id , Status__c,Invoice_Total__c from invoice__C where Invoice_Total__c>100] ){
            
            invoiceRecord.status__c ='closed';
            listToUpdate.add(invoiceRecord);
        }
        if(listToUpdate.size()>0){
            update listToUpdate;
        }
        
        //if no rollup summary without best practices
       for(invoice__C invoiceRecord :[select id , Status__c, (Select id,line_item_total__c from Line_Items__r  ) from invoice__C ] ){
           decimal sumofammount=0;
           for(Line_Item__c lineItemrecord:invoiceRecord.Line_Items__r){
               sumofammount=sumofammount+lineItemrecord.line_item_total__c;
               if(sumofammount>100){
                  invoiceRecord.Status__c='Closed';
                  listToUpdate.add(invoiceRecord);
                   break;
               }
           }
       }
         if(listToUpdate.size()>0){
            update listToUpdate;
        }
        
        //if no rollup summary with best practices
        //MAp to  be used to avoid for in a for...
        //
        //Invoice A- LIne item 1,2,3,4,5,6,7,8
        //1-10
        //2-20
        //3-10
        //4-10.....
        //A-50,B-40,C-100,D-200
        Map<Id,decimal> mapOrderIdWithSumtotal= new Map<Id,decimal>();
        for(Line_Item__c lineItemRecord:[Select id,line_item_total__c,invoice__c from Line_Item__c]){
            if(mapOrderIdWithSumtotal.containsKey(lineItemRecord.invoice__c)){
                decimal total=mapOrderIdWithSumtotal.get(lineItemRecord.invoice__c)+lineItemRecord.line_item_total__c;
           mapOrderIdWithSumtotal.put(lineItemRecord.invoice__c,total);
            }
            else{
                 mapOrderIdWithSumtotal.put(lineItemRecord.invoice__c,lineItemRecord.line_item_total__c);
               // ----------------------------A---10+20=30+10=40
            }
        }
        if(mapOrderIdWithSumtotal.size()>0){
            for(Invoice__C invoiceRecord:[select id,Status__C from Invoice__C where id in:mapOrderIdWithSumtotal.keyset()]){
                if( mapOrderIdWithSumtotal.containsKey(invoiceRecord.Id) && mapOrderIdWithSumtotal.get(invoiceRecord.Id)>100){
                invoiceRecord.Status__c='Closed';
                listToUpdate.add(invoiceRecord);
                }
            }
        }
            if(listToUpdate.size()>0){
            update listToUpdate;
        }
         
        
    }
    public void lineItemUnitPrice()
    {
     
       list<Line_Item__c> listUnitPrice = new  list<Line_Item__C>();
      // Map<Id,Integer> mapIdWithSumtotal= new Map<Id,Integer>();
       for(merchandise__c merchandiseRecords:[Select id,price__c,(select id,name,unit_price__c from line_items__r) from merchandise__c]){
           //if(mapIdWithSumtotal.containsKey(merchandiseRecords.id)){
             //integer total=mapIdWithSumtotal.get(merchandiseRecords.id)+merchandiseRecords.id;
            Integer sizeOfLineItems= merchandiseRecords.line_items__r.size();
               Decimal unitPrice=merchandiseRecords.price__c/sizeOfLineItems;
               for(Line_Item__c unitPrices :merchandiseRecords.line_items__r)
               {
                   unitPrices.Unit_price__c=unitPrice;
                   listUnitprice.add(unitPrices);
               }
           }
        if(listUnitprice.size()>0)
        {
        update listUnitprice;
        }
        
   }
         
    
    public void updateOrderComplete()
    {
        list<  invoice__C> listToUpdate= new  list<  invoice__C>();
        for(line_item__c listItemRecord:[select id,name,merchandise__r.order_complete__c,invoice__r.order_complete__c from line_item__c]){
            if(listItemRecord.merchandise__r.order_complete__c=true)
            {
                listItemRecord.invoice__r.order_complete__c=true;
                
            }
        }
    }
    
}
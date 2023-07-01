public class merchandiseRelatedInvoiceVF {
    
     public List<Merchandise__c> memList {get;set;}
   public merchandiseRelatedInvoiceVF(){
       memList = [select id,Name,(select id,Name,Invoice__r.Name,Invoice__r.name__c from Line_items__r) from Merchandise__c limit 10];
    }
 
}
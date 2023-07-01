public class Assign13 {
    public void insertInvoice()
    {
        Invoice__c inv1 = new Invoice__c(Status__c='closed');
       
        insert inv1;
    }
        
        public void query()
        {
            List<Invoice__C> myInv = [Select Id, Name, Status__c From Invoice__c limit 10];
            system.debug(myInv);
        }
  

      public void updateValue()
    {
        List<invoice__C> value = [Select id,name,Status__c,value__c From invoice__C Where value__c = null];
        for(invoice__C acct : value){
         if(invoice__c.value__c == null){
        acct.value__c =100;
         }
     }
    update value;
    }
     
    
}
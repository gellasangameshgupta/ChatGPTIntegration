public class AccountBatchClassToCountContact implements Database.Batchable<sObject> {
    
      public Database.QueryLocator start(Database.BatchableContext bc)
      {
        return Database.getQueryLocator('select id,name,No_of_contacts__c,(select id,lastname from contacts) from account');
              
      }
      public void execute(Database.BatchableContext bc, List<Account> scope){
         List<Account> accountList = new List<Account>();
         
          For(Account accountRecord : scope )
          {
             accountRecord.No_of_contacts__c = accountRecord.contacts.size();
             accountList.add(accountRecord);
          }
          if(accountList.size() > 0)
          {
              update accountList;
          }
      }
      public void finish(Database.BatchableContext bc)
     {
         
     }
}
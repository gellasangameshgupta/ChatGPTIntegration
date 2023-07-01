public class AccountBatchClass implements Database.Batchable<sObject> {
       
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator('select id,name from account');
              
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        List<Account> accountList = new List<Account>();
         for(Account accountRecord : scope)
         {
             if(accountRecord.name.length() < 30)
             {
             accountRecord.name = 'Absyz '+accountRecord.name;
             accountList.add(accountRecord);
             }
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
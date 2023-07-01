trigger accountTrigger on Account (after insert,before insert, after update) {
    if (trigger.isafter && trigger.isinsert){
        List<Account> accountList = new List<Account>();
        for(Account accountRecord : trigger.new)
        {
            accountList.add(accountRecord);
        }
        queueInterface qe= new queueInterface(accountList);
        Id jobId = System.enqueueJob(qe);
        System.debug('Job Id:::'+jobId);
    }
    if (trigger.isbefore && trigger.isinsert){
        
    }
    if (trigger.isafter && trigger.isupdate){
      //  AccountTriggerHandler.updateAccounts(trigger.new);
    }
    
}
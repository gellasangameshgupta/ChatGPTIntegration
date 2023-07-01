public class queueInterface implements Queueable {
    
    List<Account> accList = new List<Account>();
    public queueInterface(List<Account> accountList)
    {
        accList=accountList;
    }
    
    public void execute(QueueableContext context)
    {
        List<task> taskList = new List<Task>();
        for(Account accRecord : accList)
        {
            Task t = new Task();
            t.Subject='created from Queueable';
            t.WhatId=accRecord.Id;
            t.Status='Open';
            t.ActivityDate=date.today();
            t.OwnerId=UserInfo.getUserId();
            taskList.add(t);
        }
        if(!taskList.isEmpty())
        {
            insert taskList;
        }
    }

}
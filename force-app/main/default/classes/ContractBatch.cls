public class ContractBatch implements Database.Batchable < sObject >, Database.Stateful {
     Public Map<Id,Contract> contractsMap = new Map<Id,Contract>();
     public Database.QueryLocator start(Database.BatchableContext BC) {
          return Database.getQueryLocator('Select Id, ContractNumber, CustomerSignedId, StartDate, EndDate,Status, AccountId, Opportunity__c from Contract');
     }
    public void execute(Database.BatchableContext BC, list<Contract> scope){
          EmailTemplate emailTemplate = [Select Id,Subject,Description,Body from EmailTemplate where DeveloperName = 'Contract_Sample' limit 1];
          List<Messaging.SingleEmailMessage> mails = new List <Messaging.SingleEmailMessage> ();
          contractsMap = New Map<Id,Contract>(scope);
          for(Contract contractList : scope){
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             mail.setTemplateId(emailTemplate.Id);
        //     mail.setPlainTextBody(emailTemplate.Body);
        //      mail.setSubject(emailTemplate.Subject);
             mail.setTargetObjectId(contractList.CustomerSignedId);
             mail.setWhatId(contractList.Id);
             mail.setSaveAsActivity(True);
       //      mail.setToAddresses(new List<String> {'drjhaaman@gmail.com'});
             System.debug('Execute Method');
             mails.add(mail);
          }
        if(mails.size() > 0){
            Messaging.sendEmail(mails);
        }
    } 
    
    
    Public void finish(Database.BatchableContext BC) {
        List<Task> taskList = [Select Id, whatId,type from task where whatId IN : contractsMap.keySet() AND TaskSubtype = 'Email'];
        List<Task> taskToUpdate = new List<Task>();
        System.debug('taskList...'+taskList);
        System.debug('map......'+contractsMap);
        for(Task tasks : taskList){
            if(contractsMap.get(tasks.whatId).Opportunity__c != null){
                tasks.whatId = contractsMap.get(tasks.whatId).Opportunity__c;
                taskToUpdate.add(tasks);
            }
        }
        if(taskToUpdate.size() > 0){
         //   update taskToUpdate;
        }
    }

}
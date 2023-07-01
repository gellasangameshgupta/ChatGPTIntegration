global class ContactCountSchedular implements Schedulable {
    
     global void execute(SchedulableContext sc) {
         
         AccountBatchClassToCountContact countContact = new AccountBatchClassToCountContact();
         Database.executebatch(countContact);
         
     }

}
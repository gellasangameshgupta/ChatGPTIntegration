global class AccountBatchSchedular implements Schedulable{
   
    global void execute(SchedulableContext sc) {
       
      AccountBatchClass accountBatch = new AccountBatchClass();
      database.executebatch(accountBatch);
   }

}
global class LineItemDeleteScheduler implements Schedulable {
    
    global void execute(SchedulableContext sc) {
       
      LineItemsDeleteBatchClass DeleteBatch = new LineItemsDeleteBatchClass();
      Database.executebatch(DeleteBatch);
   }
    

}
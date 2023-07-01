global class BounceCustomerSchedule implements Schedulable {
    
    
     global void execute(SchedulableContext sc) {
       
      BounceCustomerBatch bounce = new BounceCustomerBatch();
      database.executebatch(bounce);
   }
    

}
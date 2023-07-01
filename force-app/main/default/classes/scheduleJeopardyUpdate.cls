global class scheduleJeopardyUpdate implements Schedulable {
    
     global void execute(SchedulableContext SC) {
        List<ServiceAppointment> listToUpdate = new List<ServiceAppointment>();
         
          for(ServiceAppointment sarecords :  [select id,AppointmentNumber,ArrivalWindowStartTime,ArrivalWindowEndTime,DueDate,
                                            FSL__InJeopardy__c from ServiceAppointment where status != 'On Site' and 
                                            status != 'Completed' and status !='Canceled' and Status !='Cannot Complete' 
                                            and ArrivalWindowEndTime = today]){
            
               sarecords.FSL__InJeopardyReason__c = 'true'; 
               listToUpdate.add(sarecords);
        }
        if(listToUpdate.size() >0){
            update listToUpdate;
        }
         
     }

}
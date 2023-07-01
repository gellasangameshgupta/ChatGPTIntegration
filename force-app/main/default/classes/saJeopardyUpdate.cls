public class saJeopardyUpdate {
    
    public static void updateJeopardy(){
        List<ServiceAppointment> listToUpdate = new List<ServiceAppointment>();
        
        List<ServiceAppointment> saList = [select id,AppointmentNumber,ArrivalWindowStartTime,ArrivalWindowEndTime,DueDate,
                                            FSL__InJeopardy__c from ServiceAppointment where status != 'On Site' and 
                                            status != 'Completed' and status !='Canceled' and Status !='Cannot Complete' 
                                            and ArrivalWindowEndTime = today ];
        // DateTime day1 = saList.ArrivalWindowEndTime.getTime();
        
        for(ServiceAppointment sarecords : saList){
            
               sarecords.FSL__InJeopardy__c = true; 
               listToUpdate.add(sarecords);
        }
        if(listToUpdate.size() >0){
            update listToUpdate;
        }
    } 

}
public class WorkOrder {
    
    public static void updateWorkOrder(List<ServiceAppointment> saList){
        
        Set<Id> woId = new set<Id>();
        for(ServiceAppointment saRecords : saList){
                woId.add(saRecords.ParentRecordId);
        }
        
        List<ServiceAppointment> serviceList = new List<ServiceAppointment>([select id,status from ServiceAppointment where ParentRecordId IN : woId]); 
         
    }

}
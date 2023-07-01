public class ServiceReportTriggerHandler {
    
    public static void updateServiceReportName(List<ServiceReport> serviceReportList){
        List<ServiceReport> reportsToUpdate = new List<ServiceReport>();
        for(ServiceReport serviceReportRecords : serviceReportList){
            serviceReportRecords.DocumentName = 'Case-'+serviceReportRecords.DocumentName;
            reportsToUpdate.add(serviceReportRecords);
        }
        if(reportsToUpdate.size() > 0){
            upsert reportsToUpdate;
        }
    }
   
}
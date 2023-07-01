trigger ServiceReportTrigger on ServiceReport (before insert, after insert) {
    if(trigger.isBefore && trigger.isInsert){
      //  ServiceReportTriggerHandler.updateServiceReportName(trigger.New);
    }
    if(trigger.isafter && trigger.isInsert){
        system.debug('entered trigger');
      //  ServiceReportTriggerHandler.updateServiceReportName(trigger.New);
    }


}
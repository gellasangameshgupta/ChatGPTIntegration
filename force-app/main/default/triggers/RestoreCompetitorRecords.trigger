trigger RestoreCompetitorRecords on Competitor__c (After Undelete) {
   Set<Id> competitorsId = new Set<Id>();
    
        if (trigger.isUndelete)
        {
             CompitetorUndeletedRecordHandler.updateBin(Trigger.new);  
        }
   
	
}
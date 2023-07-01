public class CompitetorUndeletedRecordHandler {
    public static void updateBin(List<Competitor__c> competitorsList) {
        
        List<Competitor__c> queriedCompetitorList = new List<Competitor__c>();
        
        List<Competitor__c> updateCompetitorList = new List<Competitor__c>();
        
        Set<Id> competitorId = new Set<Id>();
        
        for(Competitor__c competitorRecord: competitorsList ) 
        {
           competitorId.add(competitorRecord.Id);
        }
        
        queriedCompetitorList = [select id,undeleted_record__c from competitor__c where id in : competitorId];
        
          for(Competitor__c competitorRecord: queriedCompetitorList ) 
        {
              competitorRecord.Undeleted_Record__c = true;
              updateCompetitorList.add(competitorRecord);
        }        
        
        if(updateCompetitorList.size() > 0)
        {
        update updateCompetitorList;
        }
    }

}
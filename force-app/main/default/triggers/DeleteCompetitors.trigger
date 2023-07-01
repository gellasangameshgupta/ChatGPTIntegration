trigger DeleteCompetitors on Opportunity (before delete) {
      list<id> opportunityIds=new list<id>();
    for(Opportunity opportunityRecord:trigger.old)
    {
        opportunityIds.add(opportunityRecord.id);
    }  
    //Collecting all child records related to Parent records
    list<Competitor__c> listOfCompetitor=[select id from Competitor__c  where opportunity__r.id in :opportunityIds];
    system.debug('listOfContacts'+listOfCompetitor);
    //deleting child records
    delete listOfCompetitor;
    

}
public with sharing class lwcOpportunitySearch {
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> findOpportunity(Double searchKey) {
        Double key = searchKey;
        return [
            SELECT Id, Name,Amount
            FROM Opportunity
            WHERE Amount=:key
            LIMIT 10
        
        ];
    }
}
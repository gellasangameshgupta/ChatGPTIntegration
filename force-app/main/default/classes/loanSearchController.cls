public with sharing class loanSearchController {
    @AuraEnabled(cacheable=true)
    public static List<Loan__c> findLoan(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id, Name
            FROM Loan__c
            WHERE Name LIKE :key 
            LIMIT 10
        ];
    }
}
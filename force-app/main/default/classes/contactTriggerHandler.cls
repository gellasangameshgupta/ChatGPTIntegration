public class contactTriggerHandler {
    public static void updateContactEmail(List<contact> listOfContact)
    {
        Set<id> accountIds = new Set<id>();
        Map<id,String> accountEmailMap = new Map<id,String>();
        for (contact con : listOfContact)
        {
            accountIds.add(con.AccountId);
        }
        
        List<Account> listOfAccount = [select id,name,email__c from account where id in : accountIds];
        
        for(Account acc : listOfAccount)
        {
            accountEmailMap.put(acc.id,acc.email__c);
        }
        for (contact con : listOfContact)
        {
            if(accountEmailMap.get(con.AccountId) != null)
            {
                con.Email = accountEmailMap.get(con.AccountId);
            }
        }
    }
    public static void updateSumAmountOfOpportunity(List<Contact> con){
        Map<Id,Contact> acmp = new Map<Id,Contact>();
        for(Contact acc: con){
            acmp.put(acc.AccountId, acc);
        }
    
        for(AggregateResult arr : [select AccountId, sum(Weight__c) weight from contact where accountId in: acmp.keyset() group by accountId]){
           // Id accId = acmp.get(arr.accountId);
           Id accountId = (Id) arr.get('AccountId');
        }
        
        
    }
    
}
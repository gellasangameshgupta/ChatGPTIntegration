public class AccountTriggerHandler {
    public static boolean recursive = false;
    
    public static void updateAccounts(List<Account> accountList){
        List<Account> accountsToUpdate = new List<Account>();
        Set<Id> accountId = new Set<Id>();
        for(Account acc : accountList){
            accountId.add(acc.Id);
        }
        for(Account accountRecord :[select id, name,BillingState,ShippingState from account where Id in:accountId]){
            if(accountRecord.BillingState != null && recursive == false){
                accountRecord.ShippingState = accountRecord.BillingState;
                accountsToUpdate.add(accountRecord);
            }
        }
        recursive = true;
        if(accountsToUpdate.size() > 0){
            update accountsToUpdate;
        }
    }
    
}
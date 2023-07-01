public class ContactTriggerHandler6 {
    public static void updatePrimaryContactInsert(List<contact> contactList)
    {
        List<contact> contactUpdateList = new List<contact>();
        List<Account> accountUpdateList = new List<Account>();
        
        Set<Id> accountIdSet = new Set<Id>();
        Map<id,String> accountContactMap = new Map<id,String>();
        
        for(Contact contactRecord : contactList)
        {
            if(contactRecord.primary_contact__c = true)
            {
                accountIdSet.add(contactRecord.AccountId);
                accountContactMap.put(contactRecord.AccountId,contactRecord.LastName);
            }
        }
        List<contact> contactListToUpdate = [select id,name,AccountId,primary_contact__c from contact where AccountId in : accountIdSet];
        List<Account> AccountListToUpdate = [select id,name,primary_contact_name__c from account where Id in : accountIdSet];
        
        for(contact contactRecord : contactListToUpdate)
        {
            contactRecord.primary_contact__c = false;
            contactUpdateList.add(contactRecord);
        }
        
        for(Account accountRecord : AccountListToUpdate)
        {
            accountRecord.primary_contact_name__c = accountContactMap.get(accountRecord.id );
            accountUpdateList.add(accountRecord);
        }
        if(accountUpdateList.size() > 0)
        {
            update accountUpdateList;
        }
        if(contactUpdateList.size() > 0)
        {
            update contactUpdateList;
        }
    }
    public static void updatePrimaryContactOnUpdate(List<contact> listOfContact)
    {
        List<contact> contactUpdateList = new List<contact>();
        List<Account> accountUpdateList = new List<Account>();
        
        Set<Id> accountIdSet = new Set<Id>();
        Map<id,String> accountContactMap = new Map<id,String>();
        Set<id> contactIdSet = new Set<id>();
        
        for(contact contactRecord : listOfContact){
            accountIdSet.add(contactRecord.AccountId);
            accountContactMap.put(contactRecord.AccountId,contactRecord.LastName);
            contactIdSet.add(contactRecord.Id);
        }    
        List<contact> listOfContactToUpdate = [select id,Name,AccountId,primary_contact__c from contact where AccountId in :accountIdSet
                                                                                                    AND Id NOT IN : contactIdSet];
        
          List<Account> AccountListToUpdate = [select id,name,primary_contact_name__c from account where Id in : accountIdSet];
        
        for(contact contactRecord : listOfContactToUpdate)
        {
            contactRecord.primary_contact__c = false;
            contactUpdateList.add(contactRecord);
        }
        
        for(Account accountRecord : AccountListToUpdate)
        {
            accountRecord.primary_contact_name__c = accountContactMap.get(accountRecord.id );
            accountUpdateList.add(accountRecord);
        }
        if(accountUpdateList.size() > 0)
        {
            update accountUpdateList;
        }
        if(contactUpdateList.size() > 0)
        {
            update contactUpdateList;
        }
    }

}
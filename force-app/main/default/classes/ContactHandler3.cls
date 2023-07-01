public class ContactHandler3 {
    
    public static void primaryFieldUpdate(List<contact> listOfContact)
    {
        Map<id,String> mapOfAccountIdContactName = new map<id,String>();
        String query = 'select id,name,primary_contact__c from contact' +' where status = \'New\' And status = \'Rejected\'' ;
        if(listOfContact.size() >0){
        for(contact contactRecord : listOfContact)
        {
            string contactName = contactRecord.FirstName + contactRecord.LastName ;
            mapOfAccountIdContactName.put(contactRecord.AccountId,contactName);
        }
        }
        List<contact> ContactRecords= new List<contact>();
        if(mapOfAccountIdContactName.size() > 0 && listOfContact.size() >0)
        {
           for(contact  conRecord : [select id,name,primary_contact__c from contact where AccountId in : mapOfAccountIdContactName.keyset()
                                     and primary_contact__c = true and id not in :listOfContact])
           {
                                         
                        conRecord.primary_contact__c = false;                 
                         ContactRecords.add(conRecord);                
            }
            
        
        }
        List<Account> AccountRecords = new List<Account>();
        if(mapOfAccountIdContactName.size() > 0)
        {
            for(Account accountRecord : [select id,primary_contact_name__c from account where id in :mapOfAccountIdContactName.keyset()])
            {
                accountRecord.primary_contact_name__c = mapOfAccountIdContactName.get(accountRecord.Id);
                AccountRecords.add(accountRecord);
            }
        }
        if(accountRecords.size() > 0)
        {
            update accountRecords;
        }
        if(ContactRecords.size() >0)
        {
            update ContactRecords;
        }
    }

}
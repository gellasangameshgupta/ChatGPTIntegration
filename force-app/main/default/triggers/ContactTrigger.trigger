trigger ContactTrigger on Contact (After insert,after update) {
    
    if(trigger.isAfter)
    {
        if(trigger.IsInsert || trigger.IsUpdate)
        {
            List<contact> contactList = new List<contact>();
            for(Contact contactRecord : trigger.New)
            {
                if(contactRecord.AccountId != null &&  contactRecord.primary_contact__c == true)
                {
                    contactList.add(contactRecord);
                }
                    
            
            }
            if(contactList.size() > 0)
            {
                ContactHandler3.primaryFieldUpdate(contactList);
            }
        }
    }
    
    

}
public class CustomLookupLwcController {
    // Method to fetch lookup search result   
    @AuraEnabled(cacheable=true)
    public static list<sObject> fetchLookupData(string searchKey , string sObjectApiName) {    
        List < sObject > returnList = new List < sObject > ();

        string sWildCardText = '%' + searchKey + '%';
        
        string sQuery = 'Select Id,Name,AccountId,Phone, Email, FirstName,LastName, account.name,account.industry,account.type,account.AccountNumber,account.owner.name From ' + sObjectApiName + ' Where Name Like : sWildCardText AND accountId != null order by createdDate DESC LIMIT 5';
        string sQuery2 = 'Select Id,Name,Industry,Type,AccountNumber, Owner.Name From ' + sObjectApiName + ' Where Name Like : sWildCardText order by createdDate DESC LIMIT 5';
        string sQueryContract = 'Select Id,ContractNumber from' + sObjectApiName + ' Where ContractNumber Like : sWildCardText order by createdDate DESC LIMIT 5';
        if(sObjectApiName == 'contact'){
        for (sObject obj: database.query(sQuery)) {
            returnList.add(obj);
        }
       }
       else if(sObjectApiName == 'account'){
           for (sObject obj: database.query(sQuery2)) {
               returnList.add(obj);
           }
          }
        else if(sObjectApiName == 'contract'){
            for (sObject obj: database.query(sQueryContract)) {
                returnList.add(obj);
            }
        }
        
        return returnList;
          
    }

     
     // Method to fetch lookup default value 
     @AuraEnabled
     public static sObject fetchDefaultRecord(string recordId , string sObjectApiName) {
         string sRecId = recordId;    
         string sQuery = 'Select Id,Name From ' + sObjectApiName + ' Where Id = : sRecId  LIMIT 1';
         for (sObject obj: database.query(sQuery)) {
             return obj;
         }
         return null;
     }
     //get account details based on contactId
     @AuraEnabled(cacheable = true)
     Public static List<Account> fetchAccountRecord(String contactId){
         Set<Id> accountId = new Set<Id>();
         for( Contact contactList : [Select Id, accountId from contact where Id =: contactId]){
             if(contactList.accountId != null){
              accountId.add(contactList.accountId);
             }
  
         }
         List<Account> accountList = [select Id,name, AccountNumber,Owner.Name, Industry from Account where id IN : accountId];
         return accountList;
  
     }
    @AuraEnabled
    public static Contact createContact(Contact contactRecord){
        try{
            system.debug('contactRecord'+contactRecord);
            insert contactRecord;
            return contactRecord;
          // Database.SaveResult[] srList = Database.insert(new List<Contact>{contactRecord}, false);
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
    @AuraEnabled
    public static Account createAccount(Account accountRecord){
        try{
            system.debug('accountRecord'+accountRecord);
            insert accountRecord;
            return accountRecord;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
    @AuraEnabled
    public static Opportunity createOpportunity(Opportunity opportunityRecord){
        try{
            system.debug('opportunityRecord'+opportunityRecord);
            insert opportunityRecord;
            return opportunityRecord;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    @AuraEnabled
    public static Quote createQuote(String contactId, String opportunityId){
        try{
            system.debug('contactId:'+contactId+'opportunityId:'+opportunityId);
            Quote quoteRecord = new Quote(Name = 'Quote'+Date.today().format(), ContactId = contactId, OpportunityId = opportunityId);
            insert quoteRecord;
            return quoteRecord;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static contact fetchContactAndAccountRecords(String contactId){
        try {
            Contact contactRecord = [Select Id, FirstName, LastName, Phone, Email, Account.Name,Account.AccountNumber, Account.Industry, Account.Type,Account.Phone,Account.Owner.Name from Contact where Id=:contactId Limit 1];
            return contactRecord;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

 }
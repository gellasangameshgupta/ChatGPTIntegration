public with sharing class auraContactController {
    
    @AuraEnabled
    public static Contact createContact(Contact contact){
        upsert contact;
        return contact;
    }
   
}
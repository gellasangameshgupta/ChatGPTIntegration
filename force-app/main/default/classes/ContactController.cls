public with sharing class ContactController {
   
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
       /* return [
            SELECT FirstName, LastName, Email
            FROM Contact limit 5
        ]; */
        throw new AuraHandledException('Forced error');
    }
}
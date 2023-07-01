public with sharing class contactTableDetailsController {
   

    @AuraEnabled
    public static List<Contact> getContactRecord()
   {
        return new List<Contact>([Select Id,FirstName,LastName,Phone,Email from Contact limit 5]);
    }
}
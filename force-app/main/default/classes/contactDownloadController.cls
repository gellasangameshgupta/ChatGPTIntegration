public with sharing class contactDownloadController {
   
    @AuraEnabled(cacheable=false)
    public static List<Contact> getContact(){
        return [select id,firstname,lastname,email,account.name from contact];
    }
}
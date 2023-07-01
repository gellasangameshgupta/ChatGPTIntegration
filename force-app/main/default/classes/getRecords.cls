public with sharing class getRecords {
   
    @AuraEnabled
    public static List<SObject> getRecord(String objctName)
    {
        if(objctName == 'Contact'){
             List<SObject> sobjList = [select id,name from Contact limit 10];
             return sobjList;
        }
        else{
            List<SObject> sobjList = [select id,name from Account limit 10];
            return sobjList;
        }
    }
    @AuraEnabled
    public static void deleteRecord(Id recId){
        if(recId != null){
            SObject delRec=[select id from Contact where id=:recId];
            delete delRec;
        }
      
    }
}
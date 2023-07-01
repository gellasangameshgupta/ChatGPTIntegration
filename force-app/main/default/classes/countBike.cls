public with sharing class countBike {
    
    @AuraEnabled(cacheable=true)
    public static Integer inactiveBikes(String recordId){

        List<Bike__C>  bikeList = [SELECT id,name from Bike__c where Active__c=false and Hub__c=:recordId];
        Integer inactBike=0;
        for(Bike__c bikeRecord:bikeList)
        {
            inactBike=inactBike+1;
        }
        system.debug(inactBike);
        return inactBike;
    }

    @AuraEnabled(cacheable=true)
    public static Integer bookedBikes(String recordId){

        List<Bike__C>  bikeList = [SELECT id,name from Bike__c where Is_Booked__c=true and Hub__c=:recordId];
        Integer bookedBike=0;
        for(Bike__c bikeRecord:bikeList)
        {
            bookedBike=bookedBike+1;
        }
        system.debug(bookedBike);
        return bookedBike;
    } 

    @AuraEnabled(cacheable=true)
    public static Integer dueToServiceBikes(String recordId){

        List<Bike__C>  bikeList = [SELECT id,name from Bike__c where Due_to_Service__c=true and Hub__c=:recordId];
        Integer serviceBike=0;
        for(Bike__c bikeRecord:bikeList)
        {
            serviceBike=serviceBike+1;
        }
        system.debug(serviceBike);
        return serviceBike;
    } 

  /* @AuraEnabled(cacheable=true)
    public static Integer bookedBikes(){

        List<Bike__C>  bikeList = [SELECT id,name from Bike__c where Is_Booked__c=true];
        Integer bookedBike=0;
        for(Bike__c bikeRecord:bikeList)
        {
            bookedBike=bookedBike+1;
        }
        system.debug(bookedBike);
        return bookedBike;
    }

    @AuraEnabled(cacheable=true)
    public static Integer dueToServiceBikes(){

        Integer  serviceBike = [SELECT count(id) from Bike__c where Due_to_Service__c=true];
        return serviceBike;
    }   
   */
}
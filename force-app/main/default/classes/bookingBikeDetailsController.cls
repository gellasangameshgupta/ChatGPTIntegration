public with sharing class bookingBikeDetailsController {
   
  @AuraEnabled
  public static List<Bike__c> availableBikeHub(Id accId)
 {
      
     return new  List<Bike__c>([Select Name,(Select Distance_KM_s__c, Booking_Time__c,Customer__r.Status__c,Customer__r.Name from Bookings__r) from Bike__c where Hub__r.id =:accId limit 10]);
 }

}
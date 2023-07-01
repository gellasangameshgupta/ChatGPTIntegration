trigger BookingFare on Booking__c (before insert) {
    
    if(Trigger.isBefore && Trigger.isInsert)
    {
        LoactionFare.calculatefare(Trigger.New);
        
    }
    

}
public class LoactionFare {
   
    public static void calculatefare(List<Booking__c> bookingList)
    {
        system.debug(bookingList);
       
        List<Booking__c> updateBooking = new List<Booking__c>();
        
        decimal fare=0;
        for(Booking__c bookingHistory : bookingList )
        { 
          
            double latStart = bookingHistory.Start_Location__longitude__s;
           
            double lonStart = bookingHistory.Start_Location__latitude__s;
            
            double latEnd = bookingHistory.End_Location__longitude__s;
            double lonEnd = bookingHistory.End_Location__latitude__s;
            Location location1 = location.newInstance(latStart,lonStart);
            Location location2 = location.newInstance(latEnd,lonEnd);
            Double distance = Location.getDistance(location1,location2,'km');
            
          
            decimal hour = distance/50;
            decimal min =hour*60;
            if(distance > 75 &&  bookingHistory.RecordTypeId == 'Personal')
            {
                bookingHistory.addError('You cannot book a ride over 75km');
                
            }
            else if(distance <= 15) 
            {
               fare = distance*1 + min *1.7;
            }
            else if(distance > 15)
            {
                fare = (15*1)+(distance-15)*12 + min * 1.7;
            }
            Decimal toatlFare = fare +(fare * 0.09);
            bookingHistory.Expected_Fare__c = fare;
           // updateBooking.add(bookingHistory);
            bookingHistory.Actual_Fare__c = toatlFare;
            bookingHistory.Ride_Completed__c = true;
            updateBooking.add(bookingHistory);
                          
        }
            Set<id> bikeId = new Set<id>();
            List<Bike__c> bikeList = new List<Bike__c>();
            
            for(Booking__c bookingRecord : bookingList)
            {
                if(bookingRecord.Ride_Completed__c == true)
                {
                    bikeId.add(bookingRecord.Bike__c);
                }
            }
            List<Bike__c> bikeListRecord = new List<Bike__c>([select id,hub__c,(select id,End_Hub__c from Bookings__r) from Bike__c where Id IN :bikeId]);
            {
                for(Bike__c bikeRecord : bikeListRecord)
                {
                //    bikeRecord.hub__c =bikeRecord.End_Hub__c;
                    bikeList.add(bikeRecord);
                }
            }
      
         
    }
}
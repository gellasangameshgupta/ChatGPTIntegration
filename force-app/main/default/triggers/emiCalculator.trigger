trigger emiCalculator on Loan__c (before insert) {
    
      
    if(Trigger.isBefore && Trigger.isInsert)
    {
        EmiPayable.calculateEmi(Trigger.New);
        
    }

}
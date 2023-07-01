public class EmiPayable {
    
    public static void calculateEmi(List<Loan__c> loanList)
    {
        
         For(Loan__c loanRecord :loanList )
        {
            if(loanRecord.EMI_plan__c =='6 Months')
            {
                
                loanRecord.EMI_Payable__c = loanRecord.Loan_Amount__c/6;
                loanList.add(loanRecord);
            }
            else if(loanRecord.EMI_plan__c =='12 Months')
            {
                decimal amount = loanRecord.Loan_Amount__c/12;
                loanRecord.EMI_Payable__c = amount;
                system.debug('loanRecord.EMI_Payable__c');
                loanList.add(loanRecord);
            }
            else if(loanRecord.EMI_plan__c =='18 Months')
            {
                loanRecord.EMI_Payable__c = loanRecord.Loan_Amount__c/18;
                loanList.add(loanRecord);
            }
            else if(loanRecord.EMI_plan__c =='24 Months')
            {           
                loanRecord.EMI_Payable__c = loanRecord.Loan_Amount__c/24;
                loanList.add(loanRecord);
            }
        }
        
    }

}
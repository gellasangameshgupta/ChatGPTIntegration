@isTest
public class AccountTriggerTest {
    
     static testMethod void testAccountInsertion(){
        Integer  numberOfAccount = 200;
        List<Account> accountToInsert = new List<Account>();
         for(Integer i = 0; i<= numberOfAccount-1; i++){
             Account account = new Account();
             account.Name = 'Test';
             account.BillingState = 'CA';
             accountToInsert.add(account);
         }
         if(accountToInsert.size() > 0){
             test.startTest();
             insert accountToInsert;
             test.stopTest();
         }
       //  system.assertEquals('CA',accountToInsert.ShippingState);
    }

}
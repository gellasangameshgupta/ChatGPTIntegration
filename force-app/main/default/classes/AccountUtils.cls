public class AccountUtils {
    
    public static List<Account> accountsByState(String BillingState){
        
        return new List<Account>([Select Id,name from account where BillingState =: BillingState]);
        
    }

}
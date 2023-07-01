public class accountContactListVf {
    
     public list<Account> displayAccounts {get; set;}
    public accountContactListVf(){
        displayAccounts = [select id,name,(select id,name,Email,Phone from Contacts) from Account limit 10];
    }
}
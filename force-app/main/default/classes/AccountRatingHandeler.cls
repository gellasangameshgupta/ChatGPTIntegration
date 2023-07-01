public class AccountRatingHandeler {
    
    public static void updateRating(List<Account> accountList)
    {
        For(Account accountRecord :accountList )
        {
            if(accountRecord.industry =='Agriculture')
            {
                accountRecord.Rating = 'Hot';
                accountList.add(accountRecord);
            }
            else if(accountRecord.industry =='Consulting')
            {
                accountRecord.Rating = 'Warm';
                accountList.add(accountRecord);
            }
            else if(accountRecord.industry =='Electronics')
            {
                accountRecord.Rating = 'Cold';
                accountList.add(accountRecord);
            }
            else
            {
                accountRecord.Rating = 'Null';
                accountList.add(accountRecord);
            }
        }
        if(accountList.size() > 0)
        {
            update accountList;
        }
    }

}
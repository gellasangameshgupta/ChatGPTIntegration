public class Assign4A {
    
   
    public void check(String str)
    {
       if(str.contains('test'))
       {
           system.debug('true');
       }
       else if(str.equals('salesforce'))
       {
           system.debug('true');
       }
        else if(String.isBlank(str))
        {
            system.debug('null');
        }
    
    }

}
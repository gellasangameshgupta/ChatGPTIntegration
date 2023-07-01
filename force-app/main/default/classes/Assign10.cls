public class Assign10 {
     
    public void adjacentGretaer()
    {
         Integer[] element=new Integer[]{12,34,84,23,85,94,67,89,100,43};
         for(Integer i=0;i<=9;i++)
        {
            if(element[i]>element[0] && element[i]>element[9])
            {
                system.debug(element[i]);
            }
        }
     }
    public void countCharacter(string userInput)
    {
        Integer count=0;
        for(Integer i=0;i<=userInput.length()-1;i++)
        {
        if(userInput.containsAny(',') || userInput.containsAny('"'))
        {
            count++;
        }
        }
        system.debug(count);
      
    }

}
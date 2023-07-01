public class Assign5 {
    public string input1='rock';
    public string input2='paper';
    public string input3='scissors';
    public void playerBattle(string playerInput1,string playerInput2)
    {
      if(playerInput1.equals(input1) && playerInput2.equals(input3))
      {
             system.debug('player1 wins');
      }
      else if(playerInput1.equals(input1) && playerInput2.equals(input2))
      {
             system.debug('player2 wins');  
      }
      else  if(playerInput1.equals(input2) && playerInput2.equals(input3))
      {
             system.debug('player2 wins'); 
      }
      else  if(playerInput1.equals(input3) && playerInput2.equals(input2))
      {
             system.debug('player1 wins');
      }
      else  if(playerInput1.equals(input2) && playerInput2.equals(input1))
      {
             system.debug('player1 wins');
      }
      else  if(playerInput1.equals(input1) && playerInput2.equals(input1))
      {
             system.debug('tie');
      }
        else if(playerInput1.equals(input2) && playerInput2.equals(input2))
      {
             system.debug('tie');
      }
        else  if(playerInput1.equals(input3) && playerInput2.equals(input3))
      {
             system.debug('tie');
      }
        
        else
        {
            system.debug('invalid input');
        }
      
    }
    

}
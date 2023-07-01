public class Assign12 {
       
    public void pattern(integer n){
        string s='';
        
        for(integer i=1;i<=n;i++){
            for(integer j=1;j<=n;j++){
                
                if(i==1 ||j==n||i==n||j==1)
                    s+='* ';
                else
                     s+=' ';
                
            }
             s+='\n';
        }
        System.debug(s);
        
    }

}
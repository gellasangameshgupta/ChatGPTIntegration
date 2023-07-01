public class Assign2B {
     public void sum(integer meter1st,integer meter2nd )
    {
        integer sumOfMeter=meter1st+meter2nd;
        integer km=sumOfMeter/1000;
        integer meter=math.mod(sumOfMeter,1000);
        system.debug(km+':km:'+meter+' meter');
    }

}
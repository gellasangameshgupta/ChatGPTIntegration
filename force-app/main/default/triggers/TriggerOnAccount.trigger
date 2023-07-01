trigger TriggerOnAccount on Account (before insert,before update) {
   
    
    
    
    /* if(Trigger.isInsert && Trigger.isBefore){
        for(Account a:Trigger.new)
        {
            if(a.Industry =='Agriculture'){a.rating ='Hot';}
            else if(a.Industry =='Consulting'){a.rating ='Warm';}
            else if(a.Industry =='Electronics'){a.rating ='cold';}
            else{a.rating ='Null';}
        }
    }
    if(Trigger.isUpdate && Trigger.isBefore){
         for(Account a:Trigger.new)
        {
            if(Trigger.oldMap.get(a.id).Industry =='Null'){
            if(a.Industry =='Agriculture'){a.rating ='Hot';}
            else if(a.Industry =='Consulting'){a.rating ='Warm';}
            else if(a.Industry =='Electronics'){a.rating ='cold';}
            else{a.rating ='Null';}
            }
            
         if(Trigger.oldMap.get(a.id).Industry !='Null'){
             if(Trigger.oldMap.get(a.id).Industry !=a.Industry){ 
            if(a.Industry =='Agriculture'){a.rating ='Hot';}
            else if(a.Industry =='Consulting'){a.rating ='Warm';}
            else if(a.Industry =='Electronics'){a.rating ='cold';}
            else{a.rating ='Null';}
            }
        }
        if(a.Industry ==Null){
            a.rating =null;
        }
        }
    } */
}
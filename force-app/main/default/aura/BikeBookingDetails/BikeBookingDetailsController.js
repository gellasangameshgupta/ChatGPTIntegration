({
    doInit : function(component, event, helper) {
        
        
        var action=component.get('c.availableBikeHub');
      
		action.setParams({
            accId: component.get("v.recordId")
           
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            console.log('state ='+state);
            if (component.isValid() && state === "SUCCESS") {
               
                component.set("v.bikeList", response.getReturnValue());
                console.log('v.bikeList='+JSON.stringify(response.getReturnValue()));
              }
        });$A.enqueueAction(action);
        
    }
})
({
    doInit : function(component, event, helper) {
		var action = component.get("c.getHubRecord"); //Calling Apex class controller 'getHubRecord' method

        action.setCallback(this, function(response) {
            var state = response.getState(); //Checking response status
            var result = JSON.stringify(response.getReturnValue());
           
            console.log("result1",result);
            if (component.isValid() && state === "SUCCESS")
                component.set("v.hubLst", response.getReturnValue());  // Adding values in Aura attribute variable.
       
        });
        $A.enqueueAction(action);
	}
})
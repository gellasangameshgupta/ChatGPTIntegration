({
	init : function(component, event) {
		
	},
    
    fireComponentEvent : function(component,event){
        
        var cmpEvent = component.getEvent("cmpEvent");
        console.log('Log reached here');
        cmpEvent.setParams({
            "message" : "Component Event Fired"
        });
        cmpEvent.fire();
    }
})
({
	fireApplicationEvent : function(cmp, event) {
        
        var appEvent = $A.get("e.c:aeEvent");
        appEvent.setParams({
            "message" : "Application Event Fired"
        });
        appEvent.fire();
		
	}
})
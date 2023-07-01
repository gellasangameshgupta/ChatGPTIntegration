({
	handleComponentEvent : function(cmp, event) {
        var message = event.getParam("message");
        
         var msg = cmp.get("v.messageFromEvent") + message;
        cmp.set("v.messageFromEvent",msg);
        cmp.get("v.messageFromEvent");
        var numEventsHandled = parseInt(cmp.get("v.numEvents")) +1;
        cmp.set("v.numEvents",numEventsHandled);
		
	}
})
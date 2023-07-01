({
	 handleApplicationEvent : function(cmp, event) {
        var message = event.getParam("message");
 
        // set the handler attributes based on event data
        var msg = cmp.get("v.messageFromEvent") + message;
        cmp.set("v.messageFromEvent", msg);
        var numEventsHandled = parseInt(cmp.get("v.numEvents")) + 1;
        cmp.set("v.numEvents", numEventsHandled);
    }
	
})
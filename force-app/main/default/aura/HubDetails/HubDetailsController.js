({
    doInit : function(component, event, helper) {
        helper.getHubRecord(component); // Calling Helper method
},
navToRecord : function (component, event, helper) {
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
        "recordId": component.get("v.hub.Id")
    });
    navEvt.fire();
}
})
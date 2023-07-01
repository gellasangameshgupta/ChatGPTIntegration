({
    doInit : function(component, event, helper) {
        helper.getAccontRecord(component); // Calling Helper method
},
navToRecord : function (component, event, helper) {
    var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
        "recordId": component.get("v.account.Id")
    });
    navEvt.fire();
}
})
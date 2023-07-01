({
   doInit : function(component, event, helper){

    var objName = component.get("v.ObjectName");

    var action = component.get("c.getRecord");

    action.setParams({
        objctName:objName
    });

    action.setCallback(this, function(response){
        var state = response.getState();
        if(state == "SUCCESS"){
            console.debug(response.getReturnValue().length);
            component.set("v.data", response.getReturnValue());

        }
        else{
            console.debug(response.error[0].message);
        }
    });
    $A.enqueueAction(action);
   },

   deleteRec : function(component, event, helper){

        var action = component.get("c.deleteRecord");

        action.setParams({
            recId:event.target.id
        });

        action.setCallback(this, function(response){
            $A.get('e.force:refreshView').fire();
        });
   }
})
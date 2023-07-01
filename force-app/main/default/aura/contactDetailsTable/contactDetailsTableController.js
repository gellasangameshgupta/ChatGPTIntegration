({
    doInit : function(component, event, helper) {
		var action = component.get("c.getContactRecord"); //Calling Apex class controller 'getAccountRecord' method

        action.setCallback(this, function(response) {
            var state = response.getState(); //Checking response status
            var result = JSON.stringify(response.getReturnValue());
            if (component.isValid() && state === "SUCCESS")
                component.set("v.conLst", response.getReturnValue());  // Adding values in Aura attribute variable. 
                
                //test
                var pdfData = component.get("v.conLst");
            //    var objJsonStr = JSON.stringify(pdfData);
             //   var objJsonB64 = pdfData.toString("base64");
                var objJsonStr = JSON.stringify(pdfData);
               var objJsonB64 = btoa(objJsonStr);
            $A.createComponent(
            "c:pdfViewer",
            	{
                	"pdfData": objJsonB64
            	},
            	function(pdfViewer, status, errorMessage){
                	if (status === "SUCCESS") {
                  		var pdfContainer = component.get("v.pdfContainer");
                   		pdfContainer.push(pdfViewer);
                   		component.set("v.pdfContainer", pdfContainer);
                	}
                	else if (status === "INCOMPLETE") {
                    	console.log("No response from server or client is offline.")
                	}
                	else if (status === "ERROR") {
                    	console.log("Error: " + errorMessage);
	                }
       			}
    	);
        });
        $A.enqueueAction(action);
	},
    downloadDocument : function(component, event, helper){
        
       var pdf = component.get("v.conLst");
     //  var stringPdf = JSON.stringify(pdf);
    //   let pdfData = Buffer.from(stringPdf).toString("base64");
       var objJsonStr = JSON.stringify(pdfData);
       var objJsonB64 = btoa(objJsonStr);

       /* var sendDataProc = component.get("v.conLst");
        var dataToSend = {
           "label" : "This is test"
        }; //this is data you want to send for PDF generation
      
        //invoke vf page js method
        sendDataProc(dataToSend, function(){
                    //handle callback
        }); */
        $A.createComponent(
            "c:pdfViewer",
            	{
                	"pdfData": pdfData
            	},
            	function(pdfViewer, status, errorMessage){
                	if (status === "SUCCESS") {
                  		var pdfContainer = component.get("v.pdfContainer");
                   		pdfContainer.push(pdfViewer);
                   		component.set("v.pdfContainer", pdfContainer);
                	}
                	else if (status === "INCOMPLETE") {
                    	console.log("No response from server or client is offline.")
                	}
                	else if (status === "ERROR") {
                    	console.log("Error: " + errorMessage);
	                }
       			}
    	);
	}
       
})
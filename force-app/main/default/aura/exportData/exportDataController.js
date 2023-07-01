({
    myAction : function(component, event, helper) {

    },
    downloadCSV : function(component, event, helper){
        console.log('export');
        const jsonArray = [{"Name":"Expected Ship Date"},{"Name":"Reference Number","Value":"20003873"},{"Name":"Shipment Tracking Information"},{"Name":"Location Code","Value":"D221201"},{"Name":"Order status","Value":"CR - Order Incomplete"},{"Name":"Ace Order Number","Value":"20003873"},{"Name":"POC Email","Value":"QTKLUU@VZW.COM"},{"Name":"uniqueNum","Value":"0"},{"Name":"Service Information","Value":[{"Account Number":"0207550726-00001","MDN":"8706351836","Device ID":"","SIM":"","Item Information":[{"Item":"1 YR. MFG. WARRANTY","Item Type":"WAR6002","Quantity":"1"},{"Item":"IP14 P 128 GLD","Item Type":"MQ063LL/A","Quantity":"1"},{"Item":"G&D 5G SOFTSIM","Item Type":"UNIVESIM5G-SA-D","Quantity":"1"},{"Item":"2 DAY BY 8PM","Item Type":"SHP002","Quantity":"1"}]},{"Account Number":"0207550726- 00001","MDN":"8706351960","Device ID":"","SIM":"","Item Information":[{"Item":"IP14 P 128 GLD","Item Type":"MQ063LL/A","Quantity":"1"},{"Item":"G&D 5G SOFTSIM","Item Type":"UNIVESIM5G-SA-D","Quantity":"1"},{"Item":"2 DAY BY 8PM","Item Type":"SHP002","Quantity":"1"}]}]},{"Name":"Courier"},{"Name":"Submitted By","Value":"kallapr"},{"Name":"Customer Communication"},{"Name":"Create Timestamp","Value":"2023-02-03T09:54:55.006-05:00"},{"Name":"Complete Timestamp","Value":"1969-12-31T19:00:00.000-05:00"}];

        const csvHeaders = ["Name", "Value", "Account Number", "MDN", "Device ID", "SIM", "Item", "Item Type", "Quantity"];
        
        // Create a helper function to extract the values from the JSON object
        function extractValues(obj) {
          let values = [];
          values.push(obj.Name);
          if (obj.Value) {
            if (Array.isArray(obj.Value)) {
              obj.Value.forEach(val => {
                values.push('', val['Account Number'], val.MDN, val['Device ID'], val.SIM);
                val['Item Information'].forEach(item => {
                  values.push('', '', '', '', '', item.Item, item['Item Type'], item.Quantity);
                });
              });
            } else {
              values.push(obj.Value);
            }
          }
          return values;
        }
        
        // Convert the JSON array into a CSV string
        let csvString = csvHeaders.join(',') + '\n';
        jsonArray.forEach(obj => {
          csvString += extractValues(obj).join(',') + '\n';
        });
        
        console.log(csvString);
        var csv = csvString.toString();
        
        let link = document.createElement('a');
        link.setAttribute('href', 'data:text/csv;charset=utf-8,' + encodeURI(csvString));
        link.setAttribute('download', 'export.csv');
        link.style.display = 'none';
        document.body.appendChild(link);
    
        // Trigger the click event on the link to download the CSV
        link.click();
    }

    })
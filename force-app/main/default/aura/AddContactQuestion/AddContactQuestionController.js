({
    addRow: function(component, event, helper) {
        //get the account List from component  
        var contactList = component.get("v.conList");
        //Add New Account Record
        contactList.push({
            
           // 'FirstName': component.find("firstNameId").get("value"),
           // 'LastName': component.find("lastNameId").get("value")
    
            
        });
        component.set("v.conList", contactList);
    },
    
    removeRecord: function(component, event, helper) {
        //Get the account list
        var contactList = component.get("v.conList");
        //Get the target object
        var selectedItem = event.currentTarget;
        //Get the selected item index
        var index = selectedItem.dataset.record;
        //Remove single record from account list
        contactList.splice(index, 1);
        //Set modified account list
        component.set("v.conList", contactList);
    },
    	
    saveContact: function(component, event, helper) {      
        if (helper.validateAccountRecords(component, event)) {
            //Call Apex method and pass account list as a parameters
            var action = component.get("c.createContact");
            action.setParams({
                "conList": component.get("v.conList")
            });
            action.setCallback(this, function(response) {
                //get response status 
                var state = response.getState();
                if (state === "SUCCESS") {
                    //set empty account list
                    component.set("v.conList", []);
                    alert('Contact saved successfully');
                }
            }); 
            $A.enqueueAction(action);
        }
    },
})
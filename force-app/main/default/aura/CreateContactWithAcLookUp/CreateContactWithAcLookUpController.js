({  createContact: function(component, event, helper){
    	let accountId = component.get("v.acId");
    	let contactLastName = component.get("v.conLastName");
    
    
     	let createCon = component.get("c.createConWithLookUpAc");
    
        createCon.setParams({
            
            "lName":contactLastName,
            "acId" :accountId
            
        });
    
    
         createCon.setCallback(this, function(a) {
               var state = a.getState();
                if (state === "SUCCESS") {
                    
                   
                   alert("Contact has been created");
                }
            });
        $A.enqueueAction(createCon);
           
	},
    
    
	doInit : function(component, event, helper) {
        
        
        let acList = component.get("c.getAccountList");
        
        
        
        acList.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
                
                component.set("v.accList",a.getReturnValue());
               
               alert("Account has been fetched");
            }
        });
    $A.enqueueAction(acList);
        
   
		
	},
    
    onAccountSelect:function(component, event, helper) {
    
    	var selectAc = component.find("selectAccount").get("v.value");
        
        
        component.set("v.acId",selectAc);
        
        console.log('acIdis'+component.get("v.acId"));
    
   
    
		}
})
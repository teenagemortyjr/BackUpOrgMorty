({
	insert : function(component, event, helper) {
        
        
        var acName = component.get("v.accountName");
        var phone = component.get("v.phone");
        var rating = component.get("v.rating");
        var acNumber = component.get("v.accountNumber");
        var numberOfEmp = component.get("v.numberOfEmployee");
   
        
        var createAc = component.get("c.insertAccount");
        
        createAc.setParams({ 
            accountName:acName,
            accountNumber:acNumber,
            phoneNumber:phone,
            Rating:rating,
            noOfEmp:numberOfEmp
            
        });
        
        
         
        createAc.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
               
               alert("Account has been created with rating "+rating);
            }
        });
    $A.enqueueAction(createAc);
        
        
	}
})
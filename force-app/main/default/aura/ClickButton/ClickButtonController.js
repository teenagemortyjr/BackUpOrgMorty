({
	showAlert : function(component, event, helper) {
        
        var data = component.get("v.count");
        var setCount = component.get("c.insertCount");
       
        data = data + 1;
        
        
        component.set("v.count",data);
        
        var setCount = component.get("c.insertCount");

        setCount.setParams({ 
            "count": data
        });
        
         $A.enqueueAction(setCount)
        
        console.log('PRint the count ===>>>> '+data);
        
        
        
        
	}
})
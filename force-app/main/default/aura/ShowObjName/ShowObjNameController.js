({
    showFiled : function(component, event, helper){
        
        var value = component.find("objListSelect").get("v.value");
        console.log('onSelect click');
        component.set("v.selectedObj",value);
        console.log('after setting value-->'+JSON.stringify(component.get("v.selectedObj")));
        
        let getField = component.get("c.getObjFieldName");
        let objName = component.get("v.selectedObj");
        
        getField.setParams({
            
            "objName": objName
            
        });
        
        getField.setCallback(this, function(a) {
			console.log("inside calling  field");
           var state = a.getState();
            if (state === "SUCCESS") {
                console.log(a.getReturnValue());
                component.set("v.filedName",a.getReturnValue());
                console.log("here is value-->"+component.get("v.filedName"));
            }
        });
        
            $A.enqueueAction(getField);
        
    },
    
    
	doInit : function(component, event, helper){
        
        alert("working");
        var getName = component.get("c.getAllObjName");
        
        
         getName.setCallback(this, function(a) {
			console.log("inside calling");
           var state = a.getState();
            if (state === "SUCCESS") {
                console.log(a.getReturnValue());
                component.set("v.objName",a.getReturnValue());
                console.log("here is value-->"+component.get("v.objName"));
            }
        });
        
        
        $A.enqueueAction(getName);
        
        
        
        
        
        
        
        
		
	}
})
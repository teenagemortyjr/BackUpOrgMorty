({  
    acSort :  function(component, event, helper){
        
        var flag = component.get("v.flag");
        
        console.log(flag);
        
        if(flag){
        var acList = component.get("v.acList");
         acList =  acList.sort((a, b) => (a.Name > b.Name) ? 1 : -1);
        
        component.set("v.acList",acList);
        console.log("---"+acList);
        }else{
			var acList = component.get("v.acList");
         acList =  acList.sort((a, b) => (a.Name < b.Name) ? 1 : -1);
        
        component.set("v.acList",acList);
        console.log("---"+acList);            
            
        }
        
        
         if(flag){
            flag = false;
        }else{
            flag = true;
        }
        
        component.set("v.flag",flag);
        console.log(flag);
        
        
        
    },
    
       
    doinit : function(component, event, helper){
    
    var accList = component.get("c.getAccountList");
    
    
      accList.setCallback(this, function(a) {
               var state = a.getState();
                if (state === "SUCCESS") {
                    component.set("v.acList",a.getReturnValue());
                   
                   alert("Contact has been created");
                }
            });
        $A.enqueueAction(accList);
           
    
    
    
    
    
   },
    
    
    
	AcSort : function(component, event, helper) {
        
		
	}
})
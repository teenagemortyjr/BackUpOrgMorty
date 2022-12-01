({
    
    showSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'Log In completed',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
    },
    
    showError : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Error',
            message:'Wrong Username password',
            duration:' 5000',
            key: 'info_alt',
            type: 'error',
            mode: 'pester'
        });
        toastEvent.fire();
    }
    ,
    
	onClick : function(component, event, helper) {
        
       let uName = component.get('v.userName');
       let realUname = null;
       let realPass = null;
       let pass =  component.get('v.password');
       let contactId = component.get('v.recordId');
       let flag = component.get('v.flag');
       console.log('record id-->'+contactId);
       
        
        if(uName && pass){
            
            let getUserName = component.get('c.getUserNameAndPassword');
            
            getUserName.setParams({
                "conId": contactId
            });
            
            getUserName.setCallback(this, function(a) {
			console.log("inside calling");
           var state = a.getState();
            if (state === "SUCCESS") {
                
                realUname = a.getReturnValue().uName;
                realPass = a.getReturnValue().pass;
                console.log('realuName--> '+realUname+'pass--> '+realPass);
                
                if(realUname == uName && realPass == pass){
                    component.set('v.flag','true');
                    $A.enqueueAction(component.get('c.showSuccess'));
                    
                }else{
                    component.set('v.flag','false');
                    
                    $A.enqueueAction(component.get('c.showError'));
                    
                }
               
               
            }
        });
        
     $A.enqueueAction(getUserName);
            
            
            
            
        }else{
            
            alert('Please enter username and password');
        }
		
	}
})
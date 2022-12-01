({
	loginBtn : function(component, event, helper) {
        
        let flagForLogin = component.set('v.flagForLogin',true);
        let flagForSignUp = component.set('v.flagForSignUp',false);
		
	},
    
    signUpBtn : function(component, event, helper) {
        
        let repeatPass = component.get('v.passwordRepeat');
        let pass = component.get('v.password');
        let name = component.get('v.name');
        let uName = component.get('v.userName');
        
        let createUserDatabase = component.get('c.createUserDatabase');
        
        
        if(repeatPass && pass && name && uName){
            console.log("everthing is fine need to insert this data into database");
            
            
        }else{
            alert("please enter all value");
        }
        
        
        if(pass != repeatPass){
              alert("please enter same password");
        }
        
        createUserDatabase.setParams({
            "name":name,
            "uName":uName,
            "pass":pass
        });
        
        createUserDatabase.setCallback(this, function(response) { 
            
          
        
        
        
        });
        
        
        
        
        
        $A.enqueueAction(createUserDatabase);
        
        
        
        
        
    }
    
    
})
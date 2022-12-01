({
    addTodo : function(component, event, helper){
        
        let uName = component.get('v.userName');
        let pass = component.get('v.userPass');
        let newTodo = component.get('v.newTodo');
        console.log('new todo-->'+newTodo);
       // alert('jaofsjoaijf');
        
        let addTodo = component.get('c.addTodo1');
        
		
        addTodo.setParams({
           
            "uName":uName,
            "pass":pass,
            "newTodo":newTodo
        });
        
        addTodo.setCallback(this, function(response) { 
            
        
        
        });
        
        
         $A.enqueueAction(addTodo);
                
        
        
        
    },
    
    
	signUpbtn : function(component, event, helper){
        
        let flagForLogin = component.set('v.flagForLogin',false);
        let flagForSignUp = component.set('v.flagForSignUp',true);
        
        
        
		
	},
    
    loginBtn : function(component, event, helper){
        
        
        let varifyUserName = component.get('c.varifyUserName');
        
         let flagForLogin = component.set('v.flagForLogin',false);
        let uName = component.get('v.userName');
        let pass = component.get('v.userPass');
         let flagForSignUp = component.set('v.todoFlag',true);
        
        
        varifyUserName.setParams({
           
            "uName":uName,
            "pass":pass
        });
        
        varifyUserName.setCallback(this, function(response) { 
            
            
           
              console.log("here is todo value");
            console.log(response.getReturnValue());
            
            component.set('v.todoList',response.getReturnValue());
            
            
        
        
        
        });
        
        
         $A.enqueueAction(varifyUserName);
        
        
    }
})
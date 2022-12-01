({
	onLoad: function(component, event, helper) {
        
       var accAction = component.get("c.accList");
        
       accAction.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
                
                component.set("v.account",a.getReturnValue());
               
               alert("Account has been fetched");
            }
        });
    $A.enqueueAction(accAction);
        
	},
    
    
    
    onAccountSelect: function(component, event, helper){
        
    let accId = component.find('selectAccount').get('v.value'); 
    let setConOppNameList = component.get("c.showContactOpp");
   
        
        
        
        setConOppNameList.setParams({
            
            "acId":accId
            
        });
        
        
       
        
      
     setConOppNameList.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
                
                console.log('opp______'+a.getReturnValue().oppList);
                console.log('acc______'+JSON.stringify(a.getReturnValue()));
                 console.log('con______'+a.getReturnValue().conList);
                
                component.set("v.opportunity",a.getReturnValue().oppList);
                component.set("v.contact",a.getReturnValue().conList);
                
               
                alert("opp has been fetched");
            }
        });
       
        
    $A.enqueueAction(setConOppNameList);
  
   

  
    
}
})
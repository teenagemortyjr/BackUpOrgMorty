({ 
 
    doInit : function(component, event, helper) {
        var oppList = component.get("c.showOppList");
        var today = new Date();
        component.set('v.today', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
        
        
        oppList.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
                
                component.set("v.oppList",a.getReturnValue());
                alert("opportunity has been inserted ");
            }
        });
        
     $A.enqueueAction(oppList);
	
        
        
    },
    
    
    setOppId : function(component, event, helper){
         console.log('Id --> ' );
    var opId = component.find('opportunityListSlect').get('v.value');
    console.log('Id --> '+opId);
   	
        var Idopp = component.get('v.oppId');
        console.log('data id =--> '+Idopp);
      component.set('v.oppId',opId);
   
    alert("oppId is-->"+component.get('v.oppId'));
    
    
    
    },

    onOppSelect2 : function(component, event, helper){
    	
        var expdate = component.find("expdate").get("v.value");
        console.log("date is"+expdate+"and date is"+ expdate);
        
        
		var opId = component.get("v.oppId");
     
        var changeOpcloseDate = component.get("changeOppCloseDate");
        
        changeOpcloseDate.setParams({
            
            "oppId"   : opId,
            "newDate" : expdate
            
        });
        
        
         changeOpcloseDate.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
                
                alert("opportunity has been updated ");
            }
        });
        
     $A.enqueueAction(changeOpcloseDate);
	
        
        
        
        
        
        

    }
})
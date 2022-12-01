({ 
	doInit : function(component, event, helper) {
		var today = new Date();
        component.set('v.today', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
     

	},
	
	
	changeCloseDate:  function(component, event, helper) { 
		
	var opId = component.get('v.recordId');
	alert("Here is the oppId-->"+opId)
	var expdate = component.find('expdate').get('v.value');
	console.log("date is"+expdate+"and date is"+ expdate);
	alert("date is --->"+expdate);



	var changeOpcloseDate = component.get("c.changeOppCloseDate");
        
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
	
	




     },

	handleClick : function(component, event, helper) { 
        try{
            console.log('inside in my action ');
			var acId = component.find("record").get("v.recordId");
            
            var deleteAc = component.get("c.deleteAccount");
            
            deleteAc.setParams({

				"acId":acId

			})

			deleteAc.setCallback(this, function(a) {
				var state = a.getState();
				 if (state === "SUCCESS") {
						alert("Account has been deleted");
				 }
			 });
			 
		  $A.enqueueAction(deleteAc);
		 
        
        alert("you clicked "+acId);
            
        }catch(err){
            console.log('error--> '+err);
        }
		
	},
})
({
	myAction : function(component, event, helper) {
		console.log('Im in controller');
       
        var data = component.get("v.Name");
        var defaultNumberOfAccount = 1;
        var numberOfAc = component.get("v.AcNumber");
        console.log('PRint ===>>>> '+data);
         var action = component.get("c.InsertMethod");
   
        if(numberOfAc<0){
            alert('Please do not use Negative number')
        }
      
   if(!numberOfAc){
  
    action.setParams({ 
        "Apexname": data,
        "NoOfAc"  : numberOfAc
    });
   }else{
       
        action.setParams({ 
        "Apexname": data,
        "NoOfAc"  : defaultNumberOfAccount
       
       });
   }
        
        action.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
               
               alert("Account has been created "+data+" Count is "+numberOfAc);
            }
        });
    $A.enqueueAction(action);
   
    },   
  


    myAction2 : function(component, event, helper) {
	console.log('Im in controller');
       
       
        var dataDel = component.get("v.deleteName");
        console.log('PRint ===>>>> '+dataDel);
        var deleteAction = component.get("c.deleteMethod");

  
        
 
     deleteAction.setParams({
            "Apexname": dataDel
            
        });
        
        deleteAction.setCallback(this, function(a) {
           var state = a.getState(); 
           var dateDel= a.getReturnValue();
            if (state === "SUCCESS") {
               
               alert("Account has been deleted "+dateDel);
            }
        });
        
  
     $A.enqueueAction(deleteAction);
    }

})
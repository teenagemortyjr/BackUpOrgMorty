({  
    onSelect: function(component, event ,helper){
        
       // alert('you clicked on account name'+component.find('selectList').get('v.value'));
      	let acId = component.find('selectList').get('v.value');
        console.log('account Id is__>'+acId);
        
        var getConNum = component.get("c.getConNum");
        
         getConNum.setParams({ 
             "acId":acId
   			});
        
        
        getConNum.setCallback(this, function(a) {
           var state = a.getState();
            if (state === "SUCCESS") {
                
                component.set("v.conNameList",a.getReturnValue());
                alert("number of contact is "+a.getReturnValue());
            }
        });
        
     $A.enqueueAction(getConNum);
	
        
       
        
    },
    
    doInit2: function(component, event, helper) {
        
        var data  = component.get("v.accList");
        var getAcc = component.get("c.getAccountName");
        
        
        
        getAcc.setCallback(this, function(a){
            var state = a.getState();
            if (state === "SUCCESS") {
                let allData = JSON.stringify(a.getReturnValue())
                alert("hello from here "+allData);
                console.log("Account value-->"+allData[3]);
                let profileName = getAcc[0].Id;
                console.log("Id are here->"+profileName);
            }
        });
        
        
        
        
        //  $A.enqueueAction(getAcc);
        
        
    },
    
    
    doInit: function(component, event, helper) {
        
        var data  = component.get("v.accList");
        var getAcc = component.get("c.getAccountName");
        var acNameList = [];
        
        
        
        getAcc.setCallback(this, function(a){
            var state = a.getState();
            
            if (state === "SUCCESS"){
                let allData = a.getReturnValue();
                console.log('allData--->'+JSON.stringify(allData));
                component.set('v.accList',a.getReturnValue());
                /*
                let size = allData.length;
                alert("hello from here "+allData);
                
                for (let i = 0; i < size; i++) {
                    // console.log("Account Name-->"+allData[i].Name);
                    acNameList.push(allData[i].Name.toString());
                    
                }
                
                console.log(acNameList);*/
                
            }
        });
        $A.enqueueAction(getAcc);
        
        
        
        
        
        
        
        
    }
})
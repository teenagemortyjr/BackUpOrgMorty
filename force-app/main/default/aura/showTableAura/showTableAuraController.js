({
	showTable : function(component, event, helper) {
        
       
        var numArr = new Array();
        var num = component.get("v.count");
        component.set("v.flag","true");
        console.log('flag-> '+component.get('v.flag'));
       console.log('count-> '+component.get('v.count'));
           
        for(var i=1; i<=num;i++){ 
            numArr.push(i);
        }
        component.set("v.numList", numArr);
        
         console.log('numList-> '+component.get('v.numList'));
    
	}
})
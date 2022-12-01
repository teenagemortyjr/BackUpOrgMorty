({
	getApiData : function(component) {
       
        var action = component.get('c.getCovidData');
        
        action.setCallback(this, function(a) {
           var state = a.getState();
            if (state === 'SUCCESS') {
            var result  = a.getReturnValue();
                console.log("result-->"+JSON.stringify(result))
                
                let newConfirm  = result.allstates.NewConfirmed == ""?0:result.allstates.NewConfirmed
                let confirm  = result.allstates.TotalConfirmed ==""?0:result.allstates.TotalConfirmed
                let recovered  = result.allstates.TotalRecovered ==""?0:result.allstates.TotalRecovered 
                let death  = result.allstates.TotalDeaths == ""?0:result.allstates.TotalDeaths

                
                component.set('v.newConfirmed',newConfirm)
                component.set('v.confirmed',confirm)
                component.set('v.Recovered',recovered)
                component.set('v.Deaths',death)
               
                
                var arr = [];
                
                for(var i=0;i<result.countries.length;i++){
                    
                    var fetchData = {
                        id:i,
                        country:result.countries[i].Country,
                        newConfirmed:result.countries[i].NewConfirmed,
                        totalConfirmed:result.countries[i].TotalConfirmed,
                        newRecovered:result.countries[i].NewRecovered,
                        totalRecovered:result.countries[i].TotalRecovered,
                        newDeath:result.countries[i].NewDeaths,
                        totalDeath:result.countries[i].TotalDeaths
                    }
                    
                    arr.push(fetchData)
                }
                
                component.set('v.data',arr)
                console.log('Get result value--->'+result);
            
            }else if(state==='Error'){
                

                
            }
        },'ALL');
         $A.enqueueAction(action);
	   }
		
	
})
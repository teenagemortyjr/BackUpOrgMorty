({
	doInit : function(component, event, helper) {
        
        component.set('v.columns',[
            {label:'Country', fieldName: 'country', type: 'Text'},
            {label:'New Confirmed', fieldName: 'newConfirmed', type: 'Text'},
            {label:'Total Confirmed', fieldName: 'totalConfirmed', type: 'Text'},
            {label:'New Recovered', fieldName: 'newRecovered', type: 'Text'},
            {label:'Total Recovered', fieldName: 'totalRecovered', type: 'Text'},
            {label:'New Death', fieldName: 'newDeath', type: 'Text'},
            {label:'Total Death', fieldName: 'totalDeath', type: 'Text'}
            
        ]);
         
        helper.getApiData(component);
		
	}
})
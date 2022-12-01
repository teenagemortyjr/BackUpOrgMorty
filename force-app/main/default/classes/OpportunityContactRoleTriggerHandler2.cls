public class OpportunityContactRoleTriggerHandler2 {
    
    
     public static void q1(List<OpportunityContactRole> newOppConList){
        
        
        set<Id> oppListSet = new set<Id>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<OpportunityLineItem> oppLineItemList = new List<OpportunityLineItem>();
        Map<Id,Integer> oppLineFreq = new Map<Id,Integer>(); //oppIdVSLineItemNo
        Map<Id,Id> oppConRoleFreq = new Map<Id,Id>();
        Map<Id,Boolean> oppVsTrue = new Map<Id,boolean>();
        
        
        
        
        for(OpportunityContactRole opCon: newOppConList){
            
            oppListSet.add(opCon.OpportunityId);
        }
        
        
        oppList = [Select Id, StageName From Opportunity Where Id In: oppListSet  And  ( StageName = 'Prospecting' Or StageName = 'Qualification')];
        
        
        for(Opportunity op: oppList){
            
            if(!oppVsTrue.ContainsKey(op.Id)){
                oppVsTrue.put(op.Id,True);
                
            }
                    
            
            
            
            
        }
        
        system.debug('here is the list '+ oppList);
        oppLineItemList = [Select Id , OpportunityId From OpportunityLineItem Where OpportunityId In: oppListSet];
        
        
        
        for(OpportunityLineItem opLine: oppLineItemList){
            
            if(oppLineFreq.containsKey(opLine.OpportunityId)){
                Integer count = oppLineFreq.get(opLine.OpportunityId);
                count++;
                oppLineFreq.put(opLine.OpportunityId,count);
                
                
                
            }else{
                oppLineFreq.put(opLine.OpportunityId,1);
            }
        }
        
        
        /*for(OpportunityContactRole opConRole:newOppConList ){
            
            if(!oppConRoleFreq.containsKey(opConRole.ContactId)){
                
                oppConRoleFreq.put(opConRole.ContactId,opConRole.OpportunityId);
            }
        }*/
        
        
        for(OpportunityContactRole opConRole: newOppConList){
            
            if(oppLineFreq.get(opConRole.OpportunityId) == 2   && oppVsTrue.ContainsKey(opConRole.OpportunityId)) {
                opConRole.AddError('contact can not be inserted');
            }
        }
        
        
        
        
    }
    

}
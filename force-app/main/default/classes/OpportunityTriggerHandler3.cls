public class OpportunityTriggerHandler3 {
    
    
    public static void q1(List<Opportunity> newOppList){
        
        
        List<OpportunityLineItem> oppLineList = [Select Id, OpportunityId From OpportunityLineItem Where OpportunityId In: newOppList ];
        
        Map<Id,Integer> oppLineItemFreq = new Map<Id, Integer>();
        
        for(OpportunityLineItem opLine: oppLineList){
            
            if(oppLineItemFreq.containsKey(opLine.OpportunityId)){
                
                oppLineItemFreq.put(opLine.OpportunityId,1);
                    }else{
                        Integer count = oppLineItemFreq.get(opLine.OpportunityId);
                        count++;
                        oppLineItemFreq.put(opLine.OpportunityId, count);
                    }
        }
        
        for(Opportunity newOpp: newOppList){
            
            if(newOpp.StageName == 'Prospecting'  || newOpp.StageName == 'Qualification' ){
                
                
                if(oppLineItemFreq.containsKey(newOpp.Id)){
                    
                    if(oppLineItemFreq.get(newOpp.Id) == 2){
                        
                        newOpp.AddError('can not add more contact sorry');
                    }
                }
                
                
                
            }
            
            
            
        }
        
        
        
        
        
        
    }

}
public class OpportunityTriggerHandler2 {
    
     public static void onProductCreate(List<Opportunity> newOppList){
        
        
        List<OpportunityLineItem> oppLineItemList = [Select Record__c,  OpportunityId  From OpportunityLineItem Where OpportunityId In :newOppList];
        
        Map<Id,List<OpportunityLineItem>> opLineMap = new Map<Id,List<OpportunityLineItem>>();
         
         
         for(OpportunityLineItem oppList: oppLineItemList){
             
             if(opLineMap.containsKey(oppList.OpportunityId)){
                 
                 opLineMap.get(oppList.OpportunityId).add(oppList);
                 
             }
             else{
                 
             opLineMap.put(oppList.OpportunityId, new List<OpportunityLineItem>{oppList});
                 
        		 }
         }
         
         
         for(Opportunity op :newOppList){
             
             if(opLineMap.containsKey(op.Id)){
             
             for(OpportunityLineItem opLine: opLineMap.get(op.Id)){
                 
                 if(opLine.Record__c != null){
                     
                     if( opLine.Record__c == op.Name){
                         
                         op.Matching_record__c = true;
                     }
                 }
             }
             }
         }
         
         
         
         
         
  
        
        
    }

}
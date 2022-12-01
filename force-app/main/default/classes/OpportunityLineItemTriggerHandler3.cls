public class OpportunityLineItemTriggerHandler3 {
    
    
    public static void onOppLineItemCreate(List<OpportunityLineItem> newOppLineItem){
        
        
        List<OpportunityLineItem> oppLineList = [Select Name,Quantity, Opportunity.StageName From OpportunityLineItem
                                             	 Where Quantity >100 
                                                 and Opportunity.StageName = 'Closed Won'];
        
        
        
        system.debug('Here is the list --->'+ OppLineList);
        
        
        
        
        
    }

}
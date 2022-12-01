trigger OpportunityLineItemTrigger3 on OpportunityLineItem (after insert) {
    
    if(Trigger.isInsert){
    oppLineItemTriggerHandler.q1(Trigger.new);
    }

}
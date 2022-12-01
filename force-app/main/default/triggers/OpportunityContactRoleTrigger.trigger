trigger OpportunityContactRoleTrigger on OpportunityContactRole (before insert) {
    
    
        if(Trigger.isBefore && Trigger.isInsert){
      
        OpportunityContactRoleTriggerHandler2.q1(Trigger.new);
        
    }


}
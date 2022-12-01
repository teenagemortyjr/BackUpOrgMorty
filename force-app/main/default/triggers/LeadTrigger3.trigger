trigger LeadTrigger3 on Lead (before insert) {
    
    if(Trigger.isInsert){
        
        LeadTriggerHandler3.onLeadCreate(Trigger.new);
        
    }
    
}
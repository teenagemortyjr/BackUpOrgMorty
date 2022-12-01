trigger LeadTrigger on Lead (before insert) {
    
    if(Trigger.isInsert){
        
        LeadTriggerHandler.q1(Trigger.new);
        
    }

}
trigger ContactTrigger3 on Contact (after insert , before delete) {
    
    
    if(Trigger.isInsert && Trigger.isAfter){
        
        ContactTriggerHandler.countContact(Trigger.new);
    }
    
     if(Trigger.isDelete){
        system.debug('calling trigger before delete');
        ContactTriggerHandler.countContactAfterDelete(Trigger.old);
        
        
    }


}
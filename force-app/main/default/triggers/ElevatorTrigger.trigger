trigger ElevatorTrigger on Elevator__c (before insert) {
    
    
    if(Trigger.isInsert){
        ElevatorTriggerHandler.onElevatorUse(Trigger.new);
    }
    
    
    

}
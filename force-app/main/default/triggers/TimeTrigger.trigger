trigger TimeTrigger on Time__c (after insert, after update) {
    
    if(Trigger.isInsert ){
        TimeTriggerHandler.q1(Trigger.new);
        

    }
    
    if(Trigger.isUpdate){
        
        TimeTriggerHandler.q2(Trigger.new);
    }

}
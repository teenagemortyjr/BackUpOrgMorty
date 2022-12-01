trigger CaseTrigger3 on Case (after insert, before delete, after update) {
      
    if(Trigger.isInsert){
        CaseTrigger3Handler.onCaseCreate(Trigger.new);
    }
    if(Trigger.isDelete){
        CaseTrigger3Handler.onCaseDelete(Trigger.old);
    }
  

}
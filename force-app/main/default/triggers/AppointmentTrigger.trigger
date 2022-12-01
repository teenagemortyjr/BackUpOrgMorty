trigger AppointmentTrigger on Appointment__c (before insert) {
    
    
    if(Trigger.isInsert && Trigger.isBefore){
        
        AppointmentTriggerHandler.restrictPatient(Trigger.new);
    }

}
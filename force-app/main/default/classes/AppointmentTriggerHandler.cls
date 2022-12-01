public class AppointmentTriggerHandler {
    
    public static void restrictPatient(List<Appointment__c> newAppList){
        
        List<Appointment__c> appList = [Select Name, Doctor__c, Patient__c,AppointmentDate__c From Appointment__c ];
        
        for(Appointment__c ap: newAppList){
            
            Integer patientcount = 1;
            Integer docCount = 1;
           
            
            for(Appointment__c a: appList){
                
                if(a.Doctor__c == ap.Doctor__c  && a.AppointmentDate__c == ap.AppointmentDate__c){
                    
                    docCount++;
                }
                
                if(a.Patient__c == ap.Patient__c && a.Doctor__c == ap.Doctor__c && a.AppointmentDate__c == ap.AppointmentDate__c){
                    patientCount++;
                }
                
                if(patientCount>1){
                   ap.AddError('you can not get appointment try again next day ;(');
                }
                
                if(docCount>8){
                    ap.AddError(' you can not have any more appoinments today');
                }
                
            }
            
            
            
        }
        
        
        
        
    }

}
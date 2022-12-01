public class CaseTriggerHandler {
    
    public static void onDelete(List<Case> oldCase){
        
        List<Account> acList = [Select Id, No_of_new_cases__c From Account ]; 
        List<Account> newAcList = new List<Account>();
        
        
        
        for(Case c: oldCase){
            if(c.Status == 'New'){
                
                Account ac  = [Select Id , No_of_new_cases__c  From Account Where Id = :c.AccountId];
                
                
                if(ac.No_of_new_cases__c != null){
                    ac.No_of_new_cases__c = ac.No_of_new_cases__c - 1;
                }            
                
                newAcList.add(ac);
                
            } 
            
            
        }
        
        
        if(!newAcList.isEmpty()){
            update newAcList;
        }
        
        
        
        
        
        
        
        
        
    }
    
    public static void 	q1(List<Case> newCase){
        
        
        List<Account> acList = [Select Id, No_of_new_cases__c From Account ];
        
        
        List<Account> newAcList = new List<Account>();
        
        
        
        for(Case c: newCase){
            
            
            if(c.Status == 'New'){
                Account ac  = [Select Id , No_of_new_cases__c  From Account Where Id = :c.AccountId];
                
                
                if(ac.No_of_new_cases__c != null){
                    ac.No_of_new_cases__c = ac.No_of_new_cases__c + 1;
                }else{
                    ac.No_of_new_cases__c = 1;
                }
                
                newAcList.add(ac);
                
            }
            
            
            
        }
        
        if(!newAcList.isEmpty()){
            update newAcList;
        }
    }
    
    
    
    
    
    
}
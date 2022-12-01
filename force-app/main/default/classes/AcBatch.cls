global class AcBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('Select Name From Account');
    }
    global void execute(Database.BatchableContext bc, List<Account> acList){
        
        for(Account ac: acList){
            
            ac.Name = ac.Name + 'dCloud';
        }
        
        update acList;
        
        
    }    
    global void finish(Database.BatchableContext bc){
        
    }    
}
global class batchCode implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
         
        String query = 'SELECT Id, Name FROM Account';
        return Database.getQueryLocator(query);
    }

    
    global void execute(Database.BatchableContext BC, List<Account> accList) {
        
        // process each batch of records default size is 200
        
        List<Account> accList2 = new List<Account>();
        Integer size = 2000000;
        
        for(Integer i=0;i<size;i++){
            
            Account ac = new Account(Name='Account'+i);
            accList2.add(ac);
            
        }
        insert accList2;
               
        system.debug('Account list-->'+accList2);
    }   
     
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}
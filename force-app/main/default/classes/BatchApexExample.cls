global class BatchApexExample implements Database.Batchable<sObject>, Schedulable {
    global Database.QueryLocator start(Database.BatchableContext BC) {
       
        system.debug('inside the start----------------------------------');
        Date t = date.today();
        t = t.addDays(+10);
        system.debug('date is-->'+t);
        
        string conName = 'Account';
		string conNameLike = String.escapeSingleQuotes(conName.trim()) + '%';
       // List<Account> acList = [Select Id,Name,CreatedDate From Account Where CreatedDate<:t];
        //system.debug('size is'+acList.size());
       // system.debug('list is here-->'+acList);
       // system.debug('inside the start----------------------------------');
        String query = 'Select Id,Name,CreatedDate From Account Where CreatedDate<:t And Name Like :conNameLike';
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC, List<Account> accList) {
            
       
               
            system.debug('inside the batch--> '+accList);
            delete accList;
            
        
        
        
        
    }
    
      global void execute(SchedulableContext sc) {
            
       
            BatchApexExample b = new BatchApexExample();
			Database.executeBatch(b,200);
        
        
        
    }
        
       
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}
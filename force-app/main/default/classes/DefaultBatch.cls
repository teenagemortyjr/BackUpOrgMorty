global class DefaultBatch implements Database.Batchable <sObject> {
    
    
    
    global List<Account> start(Database.BatchableContext bc) {
       	List<Account> acList = [Select Id,Name From Account ];
        return acList;
        
    }
    
    global void execute(Database.BatchableContext bc,List<Account> batch) {
        system.debug('Account-->'+batch);
       List<Contact> conList = new List<Contact>();
        
        for(Account a: batch){
            Contact con = new Contact(AccountId = a.Id, LastName='Account by Batch',FirstName='Ac'+a.Name);
            system.debug('contact->'+con);
            conList.add(con);
        }
        
        Insert conList;
    }
    
    global void finish(Database.BatchableContext bc) {
        
         AsyncApexJob a = [Select Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email    from AsyncApexJob where Id =:BC.getJobId()];
      
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Match Merge Batch ' + a.Status);
        mail.setPlainTextBody('records processed ' + a.TotalJobItems +   'with '+ a.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    }
}
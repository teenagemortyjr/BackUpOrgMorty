public class QueryMaster {
    
    public static void start(){
        
       // List<Account> accList = [select Id, Name ,(Select Id,Name,AccountId from contacts),(Select Id,Name From Opportunities) from Account];
        List<Contact> accList = [Select Id, Name, Account.Name, Account.Id From Contact];
        for(Contact ac: accList){
            system.debug('ac-->'+ac.AccountId);
           
        }
       // system.debug('Account list --->'+accList);
    }

}
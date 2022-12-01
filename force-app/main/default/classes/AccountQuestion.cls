public class AccountQuestion {

    
    @TestVisible
    private static void getAccount(){
        
        Date d = system.today();
        d = d.addDays(-2);
        
       List<Account> acList = [Select Name ,CreatedDate From Account Where CreatedDate<=:d];
        system.debug('account -->'+acList);
        
        
        
    }
}
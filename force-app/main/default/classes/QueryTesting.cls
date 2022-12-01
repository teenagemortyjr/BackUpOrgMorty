public class QueryTesting {
    
    public static void test(){
        List<Contact> conList = [Select Id,  Account.Name, Account.Id From Contact];
        for(Contact con: conList){
            system.debug('conList-->'+con);
        }
        system.debug('conList-->'+conList);
    }

}
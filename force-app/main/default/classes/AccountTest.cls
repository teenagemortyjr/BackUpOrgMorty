public class AccountTest {
    
    public static void test(){
        
        
        List<Account> acList = [Select Id, Name , Rating From Account Where Rating='Cold' or name like 'A%'];
        
       // system.debug('account value is ---->'+acList);
        for(Account ac: acList){
            
            if(ac.Rating == 'Cold'){
                
                system.debug('Here is a value-->'+ac);
                
                
            }
        }
        
        
        
    }

}
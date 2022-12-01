public class CreateAcc {
    public static void showAc(){
        
        List<Account> acList = new List<Account>();
        
        acList = [Select Id,Name From Account];
        
        for(Account ac: acList){
            system.debug('acc->'+ac.Name);
        }
        
        
        
    }

}
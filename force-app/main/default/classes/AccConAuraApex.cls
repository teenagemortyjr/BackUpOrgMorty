public class AccConAuraApex {
    
    @AuraEnabled
    public static List<Account> getAccountName(){
        
        List<Account> acList = [Select id, Name  From Account LIMIT 50000];
        system.debug('account List-->'+acList);
        
        return acList;
        
    }
    
    
    
    @AuraEnabled
    public static List<Contact> getConNum(Id acId){
        
        List<Contact> conList = [Select Email, AccountId,Id,FirstName,LastName,Phone From Contact Where AccountId =:acId  Limit 50000];
        //List<String> conName = new List<String>();
        
      
        return conList;
        
    }

}
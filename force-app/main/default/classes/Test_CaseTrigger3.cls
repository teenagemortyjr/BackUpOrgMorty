@isTest
public class Test_CaseTrigger3 {
    
    @isTest
    public static void startTest(){
        
        List<Account> acList = new List<Account>();
        List<Case> caseList = new List<Case>();
      
        Account ac = new Account(Name ='Acc 1 dummy');
       
        
        insert ac;
        
        for(Integer i = 0;i<20;i++){
			Case c = new Case(AccountId = ac.Id);
            caseList.add(c);
        }
        
        insert caseList;
            
        
        delete caseList;
       
    }
}
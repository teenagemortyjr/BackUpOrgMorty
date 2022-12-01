@isTest
public class AccountQuestion_Test {
    
    @isTest
    public static void testClass(){
        
        
        
        
        Account account = new Account(Name = 'Test'); 
        insert account; 
		Datetime yesterday = Datetime.now().addDays(-2);
		Test.setCreatedDate(account.Id, yesterday);
        
        
        
        
        if( UserInfo.getName() == 'test'){
        
        Test.startTest();
        
                      AccountQuestion.getAccount();
  
        Test.stopTest();
            
        }else{
            
            system.debug('You cannot run this test class ');
        }
        
        
        
        
  
        
       
   
        
        
        
    }
    
    

}
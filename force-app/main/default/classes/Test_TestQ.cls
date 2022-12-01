@isTest
public class Test_TestQ {
    
    @isTest
    public static void startTest(){
        
        Account ac = new Account(Name='sjfsijfsi',StartDate__C = date.today(),EndDate__C = date.today());
        
        insert ac;
        Contact ca = new Contact(AccountId = ac.Id,LastName='Ln',StartDate__C = date.today(),EndDate__C = date.today());
        
        insert ca;
        
        TestQ.q1();
      
    }

}
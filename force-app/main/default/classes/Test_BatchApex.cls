@isTest
public class Test_BatchApex {
    
    @TestSetup
    public static void createRecord(){
        
        List<Account> acList = new List<Account>();
        
        for(Integer i=0;i<2000;i++){
            
            Account ac = new Account(Name='Account demo'+i);
            acList.add(ac);
        }
        
        insert acList;
        
      
        system.debug('account list is here-->size '+acList.size()+'     --- '+acList);
        
    }
    
    
    @isTest
    public static void startTest(){
        
        Test.startTest();
        
        BatchApexExample b = new BatchApexExample();
        Database.executeBatch(b,2000);
        Test.stopTest();
        
        
        
        
        
        
    }

}
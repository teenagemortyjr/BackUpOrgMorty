@isTest
public class Test_LeadTriggerHandler {
    
    @isTest
    public static void startTest(){
        
        
        List<Lead> leadList = new List<Lead>();
        List<User> userList = new List<User>();
        List<Account> acList = new List<Account>();
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        system.debug('here is profile list -->'+p);
    	User u1 = new User(Alias = 'standt1',Country='United Kingdom',Email='demo1@randomdemodomain.com',EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles', UserName='demo23@andomdemodomain.com');
		system.debug('here is user value--->'+u1);
        insert u1;
         

        
        Account ac = new Account(Name='jojo',OwnerId=u1.Id);
        
        insert ac;
        
        for(Integer i=0;i<80;i++){
            
     	    Lead l = new Lead(Company = 'cloud Analogy '+i,LastName='jojo o',OwnerId=u1.Id);
            system.debug('lead is here -->'+l);
            leadList.add(l);
            
       		 }
        
        insert leadList;
        
       // system.debug('lead is here-->'+leadList);
        
      
    }

}
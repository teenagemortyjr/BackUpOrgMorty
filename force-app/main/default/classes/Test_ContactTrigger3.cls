@isTest
public class Test_ContactTrigger3 {
    
    @isTest
    public static void startTest(){
        
        List<Contact> conList = new  List<Contact>();
        
        for(Integer i=0; i<10 ; i++){
            Contact c = new Contact(LastName='jasif');
            conList.add(c);
        }
        insert conList;
        
        List<Trello__c> trelloList = new List<Trello__c>();
        
        for(Integer i=0; i<10 ; i++){
            Trello__c t = new Trello__c(Name= 'dummy'+i, Contact__c=conList[0].Id);
            trelloList.add(t);
        }
        
        insert trelloList;
        system.debug('before update--->'+trelloList);
        Integer i = 0;
        for(Contact c: conList){
            c.LastName = 'dummy dummy'+i;
        }
        
        update conList;
        
        system.debug('after update--->'+trelloList);
        
        
        
        
        
        
        
        
        
        
        
        
    }
    

}
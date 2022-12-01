@isTest
public class Test_ElevatorTrigger {
    
    
    @testSetup
    public static void createData(){
        
        Emp__c emp = new Emp__c(Name = 'puneet');
        insert emp;
        
        Floor__c flr = new Floor__c(Name='1');
        insert flr;
                
    
    }
    
    
    
    @isTest
    public static void startTest(){
        
        List<Elevator__c> eleList = new List<Elevator__c>();

        Emp__c emp = [Select Id ,Name From Emp__c Where Name='puneet'];
        
        Floor__c flr = [Select Id,Name From Floor__c Where Name='1'];
        
        
        
         for(Integer i =0;i<10;i++){
             Elevator__c e = new Elevator__c(Name='Dummy'+i, Day__c = Date.today(),Emp__c = emp.Id,Floor__c = flr.Id);
      		 eleList.add(e);
        }
       		 insert eleList;
        
   
    }

}
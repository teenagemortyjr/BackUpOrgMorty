public class TimeTriggerHandler {
    
    public static void q1(List<Time__c> newTimeList){
        System.debug('test --->'+newTimeList);
        Date d = date.today().addDays(-30);
        
        List<Time__c > timeList = [Select Name, End_date__c ,Contact__c From Time__c Where Name Like 'a%' and End_date__c > :d and Id In :newtimeList];
              System.debug('test 1--->'+d);
        List<Contact> conList = new List<Contact>();
        system.debug('here is timeList -->'+timeList);
        
        for(Time__c t: timeList){
            
            Contact c = [Select LastName ,Id From Contact Where Id = :t.Contact__c];
            c.LastName = t.Name;
            conList.add(c);
        }
        
        
        update timeList;
        
        
        
        
        
        
        
        
        
    }
    
    public static void q2(List<Time__c> newTimeList){
        
        Date d = date.today().addDays(-30);
        
       	List<Time__c > timeList = [Select Name, End_date__c ,Contact__c From Time__c Where Name Like 'a%' and End_date__c > :d and Id In :newtimeList];
      
        List<Contact> conList = new List<Contact>();
        
        
        for(Time__c t: timeList){
            
            Contact c = [Select LastName ,Id From Contact Where Id = :t.Contact__c];
            c.LastName = t.Name;
            conList.add(c);
        }
        
        
        update timeList;
        
        
        
    }

}
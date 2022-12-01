@isTest
public class Test_TimeTrigger {
    
    @isTest
    public static void startTest(){
        
        List<Contact> conList = new List<Contact>();
        List<Time__c> timeList = new List<Time__c>();
        
        for(Integer i =0; i<3; i++){
            
            Contact con = new Contact(LastName='lastName'+i);
            conList.add(con);
        }
        
        insert conList;
        
        Date d = date.today().addDays(+40);
        
        for(Integer i=0;i<30;i++){
            if(i>20){
                Time__c t = new Time__c(Name = 'Time'+i,Contact__c = conList[0].Id,End_date__c = d);
            	timeList.add(t);                                         

            }else{
                
                 Time__c t = new Time__c(Name = 'aTime'+i,Contact__c = conList[1].Id,End_date__c = d);
            	 timeList.add(t);                                         

            }
        }
        system.debug('here is timeList ---> '+timeList);
        
        insert timeList;
        
        
        
    }

}
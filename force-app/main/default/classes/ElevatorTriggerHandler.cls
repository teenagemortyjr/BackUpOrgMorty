public class ElevatorTriggerHandler {
    
    public static void onElevatorUse(List<Elevator__c> newElevator){
        
        Set<Id> empSet = new Set<Id>();
        Set<Id> FloorSet = new Set<Id>();
        map<String,Integer> StrVsCount = new map<String,Integer>();
        List<Elevator__c> deleteElevList = new List<Elevator__c>();
        
        
        
        for(Elevator__c e: newElevator){
            
            if(e.Day__c != Date.today()){
                e.addError('You cannot choose this date');
            }
            
            empSet.add(e.Emp__c);
           // FloorSet.add(e.Floor__c);
            
        }
        Date day1 = Date.today();
        
        deleteElevList = [Select Id,Day__c From Elevator__c Where Day__c <:day1 and emp__c In: empSet ];
        
        
		system.debug('list before delete --> '+deleteElevList); 
        
        delete deleteElevList;
        
        List<Elevator__c> oldElevatorList = [Select Id,Emp__c ,Floor__c	,Day__c From Elevator__c Where Emp__c In: empSet ];
        
        
        for(Elevator__c e: oldElevatorList){
            
            Integer year = e.Day__c.year();
            Integer month = e.Day__c.Month();
            Integer day = e.Day__c.day();
            
            String dayTime = String.valueOf(year) + String.valueOf(month) + String.ValueOf(day);
            
            String key = String.valueOf( e.Emp__c) + String.valueOf(e.Floor__c) + dayTime; 
            
            if(strVsCount.containsKey(key)){
                Integer count = strVsCount.get(key);
                count++;
                strVsCount.put(key,count);
            }else{
                 strVsCount.put(key,1);
            }
            
            
        }
        
        
        
        
        for(Elevator__c e: newElevator){
            
           Integer year = e.Day__c.year();
            Integer month = e.Day__c.Month();
            Integer day = e.Day__c.day();
            
            String dayTime = String.valueOf(year) + String.valueOf(month) + String.ValueOf(day);
            
            String key = String.valueOf( e.Emp__c) + String.valueOf(e.Floor__c) + dayTime; 
            if(strVsCount.containsKey(key)){
                Integer count = strVsCount.get(key);
                if(Count>5){
                    e.addError('you should use stairs now... ;[');
                }else{
                count++;
                strVsCount.put(key,count);
                }
            }else{
                 strVsCount.put(key,1);
            }
            
            
        }
        
        
        
    }



}
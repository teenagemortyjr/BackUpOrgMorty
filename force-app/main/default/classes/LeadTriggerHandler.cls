public class LeadTriggerHandler {
    
    
    
    
    public static void q1(List<Lead> triggerlist){
        List<Lead> leadList,leadlist2 = new List<Lead>();
        List<User> userList = new List<User>();
        userlist =[select Id from User];
        leadlist = [select Id,OwnerId,LastModifiedDate from Lead where Id In :triggerlist];
        leadlist2 = [select Id,OwnerId,LastModifiedDate from Lead];
        if(triggerlist.size()==1){
            leadlist = leadlist2;
        }
        
        Map<Id,List<Lead>> leadMap = new Map<Id,List<Lead>>();
        
        for(Lead l : leadList ){
            
            if(leadMap.containsKey(l.OwnerId)){
                
                leadMap.get(l.OwnerId).add(l);
                
            }else{
                
                leadMap.put(l.OwnerId,new List<Lead>{l});
            }
            
            
        }
        
        
       // System.debug('leadlist'+leadlist);
        Integer month = null;
        for(User u : userList){
            Integer i = 0;
            month = null;
            if(leadMap.containsKey(u.Id)){
            for(Lead ld : leadMap.get(u.Id)){
                if(u.Id == ld.OwnerId){
                    if(month == null){
                        month = ld.LastModifiedDate.month();
                    }else{
                        if(ld.LastModifiedDate.month() == month){
                            i++;
                            System.debug('i'+i);
                        }
                    }
                }
                if(i>30){
                	ld.addError('you have cross the limit of change owner to user in this month');
                }
            }
            }
        }
    } 

 

}
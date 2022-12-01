public class LeadTriggerHandler3{
    
    public static void onLeadCreate(List<Lead> newLeadList){
        
        Set<Id> userSet  = new Set<Id>();
        List<Account> acList = new List<Account>();
        List<Lead> leadList = new List<Lead>();
        Map<Id,Integer> IdVsCount = new Map<Id,Integer>();
        Map<Id,Id> IdVsId = new Map<Id,Id>();
        
        for(Lead l: newLeadList){
            
            userSet.add(l.OwnerId);
        }
        
        acList = [Select Id From Account Where Id In:userSet];
        
        leadList = [Select Id ,OwnerId From Lead Where OwnerId In:userSet];
        
        
        system.debug('Lead list is here -->'+leadList);
        
        
        for(Lead l: newLeadList){
            
            if(!IdVsId.ContainsKey(l.Id)){
                IdVsId.put(l.Id,l.OwnerId);
            }
            
            if(IdVsCount.containsKey(l.OwnerId)){
                
                Integer count = IdVsCount.get(l.OwnerId);
                count++;
                IdVsCount.put(l.OwnerId,count);
            }else{
                IdVsCount.put(l.OwnerId,1);
            }        
            
        }
        
        for(Lead l: newLeadList){
            
            if(IdVsId.ContainsKey(l.Id)){
                if(IdVsCount.containsKey(IdVsId.get(l.Id))){
               Integer count = IdVsCount.get(IdVsId.get(l.Id));
                    if(count>30){
                        l.AddError('can not create anymore');
                    }
                    }
            }
        }
        
        
        
        
        
        
        
        
    }

}
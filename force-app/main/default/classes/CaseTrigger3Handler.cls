public class CaseTrigger3Handler {
    
    public static void onCaseDelete(List<Case> newCaseList){
        
        
        
          Map<Id,Account> IdVsAc = new Map<Id,Account>();
          set<Account> updateSet = new set<Account>();
          List<Account> UpdatedList = new List<Account>();
        
        
        
        for(Case c: newCaseList){
            
            if(c.Status == 'New'){

                
                if(!IdVsAc.containsKey(c.Id)){
                    Account ac = new Account();
                   ac =  [Select Id,No_of_new_cases__c  From Account where Id =:c.AccountId ];
                   
                    IdVsAc.put(c.Id,ac);
                }
            }
        }
        
        system.debug('Account value'+IdVsAc);
       
        
        for(Case c: newCaseList){
            
            if(IdVsAc.containsKey(c.Id)){
                Account ac = IdVsAc.get(c.Id);
                system.debug('current value'+ac.No_of_new_cases__c);
                
                if(ac.No_of_new_cases__c != null ){
                    system.debug('i am here');
                    ac.No_of_new_cases__c = ac.No_of_new_cases__c - 1;
                }
                
                updateSet.add(ac);
            }
        }
        system.debug('set value '+updateSet);
        
        for(Account ac: updateSet){
            updatedList.add(ac);
        }
        system.debug('updated list '+updatedList);
        
			update updatedList;        
        
    }


    
    public static void onCaseCreate(List<Case> newCaseList){
        
      
        Map<Id,Account> IdVsAc = new Map<Id,Account>();
        set<Account> updateSet = new set<Account>();
        List<Account> UpdatedList = new List<Account>();
        
        
        
        for(Case c: newCaseList){
            
            if(c.Status == 'New'){

                
                if(!IdVsAc.containsKey(c.Id)){
                    Account ac = new Account();
                   ac =  [Select Id,No_of_new_cases__c  From Account where Id =:c.AccountId ];
                   
                    IdVsAc.put(c.Id,ac);
                }
            }
        }
        
        system.debug('Account value'+IdVsAc);
       
        
        for(Case c: newCaseList){
            
            if(IdVsAc.containsKey(c.Id)){
                Account ac = IdVsAc.get(c.Id);
                system.debug('current value'+ac.No_of_new_cases__c);
                
                if(ac.No_of_new_cases__c != null){
                    system.debug('i am here With Case');
                    ac.No_of_new_cases__c = ac.No_of_new_cases__c +1;
                }else if (ac.No_of_new_cases__c == null){
                    ac.No_of_new_cases__c = 1;
                }
                
                updateSet.add(ac);
            }
        }
        
        system.debug('set value '+updateSet);
        
        
        for(Account ac: updateSet){
            updatedList.add(ac);
      
        }
        
        system.debug('updated list '+updatedList);
        
			update updatedList;        
        
    }

}
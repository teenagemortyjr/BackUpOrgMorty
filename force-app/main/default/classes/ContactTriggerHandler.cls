public class ContactTriggerHandler {
    
    
    /*
    
    public static void insertInTrello(List<Contact> newConList ){
        
        List<Trello__c> trellList = [Select Id, Name,Contact__c From Trello__c Where Contact__c In ( Select Id From Contact Where Id In :NewConList)];
        
        Map<Id,String> ConMap  = new Map<Id,String>();
        List<Trello__c> tList = new List<Trello__c>();
        
        for(Contact c: newConList){
            
            if(!ConMap.ContainsKey(c.Id)){
                
                ConMap.put(c.Id,c.LastName);
                
            }
            
            
        }
        for(Trello__c t: trellList){
            
            if(ConMap.containsKey(t.Contact__c)){
                
                t.Name =  ConMap.get(t.Contact__c);
                tList.add(t);
            }
            
            
        }
        
        
        update tList;
        
        
        
        
        
    }
    
    
    public static void onContactInsert(list<Contact> newConList){
               
        List<Contact> conList  = [Select Id,Email From Contact];
        Map<String,Integer> EMap = new Map<String,Integer>();
        
        for(Contact c: conList){
            
            if(EMap.containsKey(c.Email)){
                Integer count = Emap.get(c.Email);
                count++;
                
                EMap.put(c.Email,count);
                
            }else{
                EMap.put(c.Email, 1);
                
            }
        }
        
        
        for(Contact c: newConList){
            
            if(EMap.containsKey(c.Email)){
                c.AddError('you can not insert it');
                
                
            }
                
            
        }
        
        
        
        
        
        
        
        
    }
    
    public static void q2(List<Contact> deletedConList ){
        
        List<Account> acList = new List<Account>();
        
        
        for(Contact c: deletedConList){
            
            Account ac  = [Select Id , totalContact__c From Account Where Id = :c.AccountId];
            ac.totalContact__c  = ac.totalContact__c - 1;
            acList.add(ac);
            
            
        }
        
        update acList;
    }
    
      public static void q3(List<Contact> updatedConList ){
        
        List<Account> acList = new List<Account>();
        
        
        for(Contact c: updatedConList){
            
            Account ac  = [Select Id , totalContact__c From Account Where Id = :c.AccountId];
            ac.totalContact__c  = ac.totalContact__c + 1;
            acList.add(ac);
            
            
        }
          insert acList;
    }
    
    
    
    public static void q1(List<Contact> conList){
        
        Map<Id,Integer> conMap = new Map<Id,Integer>();
        List<Account> acList = [Select Id,totalContact__c From Account ];
        List<Account> newAcList = new List<Account>();
        
        
        for(Contact c: conList){
            
            if(conMap.containsKey(c.AccountId)){
                Integer count = conMap.get(c.AccountId);
                count++;
                conMap.put(c.AccountId,count);
                
                
            }else{
                
                conMap.put(c.AccountId,1);
            }
        }
        
        
        for(Account ac: acList){
            
            if(conMap.containsKey(ac.Id)){
                ac.totalContact__c = conMap.get(ac.Id);
                newAcList.add(ac);
			

            }
        }
        
        
        update newAcList;
        
        
        
        
       
        
        
        
        
    }
*/
    
    public static void countContactAfterDelete(List<Contact> deleteConList){
        
        system.debug('inside delete');
        
        
        system.debug('new conList --->'+deleteConList);
         Set<Id> accIdSet = new Set<Id> ();
        
        for(Contact con: deleteConList){
            accIdSet.add(con.AccountId);
        }
        system.debug('Accout ID set->'+accIdSet);
        
            
        Map<Id,decimal> AccountIdVsContactCountMap = new Map<Id,decimal>();
        
       
        
        for(Contact con: deleteConList){
            
            
            
            if(AccountIdVsContactCountMap.containsKey(con.AccountId)){
                Decimal count = AccountIdVsContactCountMap.get(con.AccountId);
                count++;
               AccountIdVsContactCountMap.put(con.AccountId,count);
                
            }else{
            AccountIdVsContactCountMap.put(con.AccountId,1);
            }
            
        }
        
        List<Account> accList = [ Select Id,totalContact__C From Account Where Id In: accIdSet];
        
        system.debug('account-->'+accList);
     
        
        for(Account ac:accList){
            
            if(AccountIdVsContactCountMap.containsKey(ac.Id)){
                
                ac.totalContact__c = ac.totalContact__c - AccountIdVsContactCountMap.get(ac.Id);
                system.debug('size of current list'+ac.totalContact__c);
                
            }
            
        }
        
        system.debug('After insert-->'+accList);
        
        update accList;
        
    }
    
    public static void countContact(List<Contact> newConList){
        system.debug('new conList --->'+newConList);
        List<Contact> oldContactList = new List<Contact>();
         Set<Id> accIdSet = new Set<Id> ();
        
        for(Contact con: newConList){
            accIdSet.add(con.AccountId);
        }
        
        oldContactList = [Select Id ,AccountId From Contact Where AccountId In:accIdSet];
            
        Map<Id,decimal> AccountIdVsContactCountMap = new Map<Id,decimal>();
        
       
        
        for(Contact con: oldContactList){
            
            
            
            if(AccountIdVsContactCountMap.containsKey(con.AccountId)){
                Decimal count = AccountIdVsContactCountMap.get(con.AccountId);
                count++;
               AccountIdVsContactCountMap.put(con.AccountId,count);
                
            }else{
            AccountIdVsContactCountMap.put(con.AccountId,1);
            }
            
        }
        system.debug('map-->'+newConList);
        
        List<Account> accList = [ Select Id,totalContact__C From Account Where Id In: accIdSet];
        
        system.debug('account-->'+accList);
     
        
        for(Account ac:accList){
            
            if(AccountIdVsContactCountMap.containsKey(ac.Id)){
                
                ac.totalContact__c = AccountIdVsContactCountMap.get(ac.Id);
                
            }
            
        }
        
        system.debug('After insert-->'+accList);
        
        update accList;
        
        
        
        
    }

}
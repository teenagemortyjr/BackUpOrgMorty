public class AccountTriggerHandler {
   
    public static void addEmail(List<Account> newAcList){
        
        List<Contact> conList = [Select Id, AccountId , Email From Contact Where AccountId In:newAcList];
        List<Account> updatedList = new List<Account>();
        
        
		//Map<Id,List<Contact>> conMap = new Map<Id, List<Contact>>();
        Map<Id,Id> conMap = new  Map<Id,Id>();
        
        List<Contact> newConList = new List<Contact>();
        
        
        
        for(Contact con: ConList){
            
            if(!conMap.containsKey(con.Id)){
                
                 conMap.put(con.Id, con.AccountId);
      
            }
        }
        
        
        for(Contact ca: conList){
            
            if(conMap.containsKey(ca.Id)){
                
                if(ca.Email != null){
                   
                    Account ac = new Account();
                    ac.Id = conMap.get(ca.Id);
                    
                    if(ac.AccountEmail__c != null){
                        ac.AccountEmail__c = ac.AccountEmail__c + ca.Email;
                    }else{
                        ac.AccountEmail__c = ca.Email;
                        
                    }
                    
                    
                    
                    updatedList.add(ac);
                    
                }
            }
            
            
        }
        
        update updatedList;
        
        
        
      
        
        
        
        
        /*
        
        for(Account ac: newAcList){
            
            if(conMap.containsKey(ac.Id)){
                
                if(conMap.get(ac.Id).size()>0){
                    
                    for(Contact con: conMap.get(ac.Id)){
                        
                        if(con.Email != null){
                            if(ac.AccountEmail__c != null){
                                ac.AccountEmail__c = ac.AccountEmail__c + con.Email;
                            }else{
                                ac.AccountEmail__c = con.Email;
                            }
                        }
                       
                        
                    }
                }else{
                    Contact ca = new Contact(AccountId = ac.Id, LastName = 'Tiwari bhai', Email  = 'Tiwaribhai@cloud.com',DefaultContact__c = true);
                    newConList.add(ca);
                }
                
                
            }
            
        }
        
       
        
        
    }
*/
    }
}
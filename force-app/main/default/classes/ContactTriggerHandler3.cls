public class ContactTriggerHandler3 {
    
    public static void changeTrelloName(List<Contact>  oldConList,List<Contact> newConList){
        
        
        Set<Id> conSet = new Set<Id>();
        List<Trello__c> trelloList = new List<Trello__c>();
        List<Trello__c> updatedTrelloList = new List<Trello__c>();
        map<Id,Contact> IdVsCon = new Map<Id,Contact>();
        map<Id,Trello__c> IdVsTrello = new map<Id,Trello__c>();
        List<Trello__c>  updateTrelloList = new List<Trello__c>();
        
        
        for(Contact con: newConList){
            
            
            if(!IdVsCon.containsKey(con.Id)){
                IdVsCon.put(con.Id,con);
                
            }
            
            
            
            
        }
        
        
        
        
        for(Contact con: oldConList){
            
            conSet.add(con.Id);
        }
        
        trelloList = [Select Id, Name, Contact__c From Trello__c Where Contact__c In:conSet];
        
        for(Trello__c t: trelloList){
            
            if(!IdVsTrello.containsKey(t.Contact__c)){
                IdVsTrello.put(t.Contact__c, t);
            }
        }
        
        
        
        system.debug('trello list-->'+trelloList);
        
        for(Contact con: oldConList){
            
            if(con.LastName != IdVsCon.get(con.Id).LastName){
                
                if(IdVsTrello.containsKey(con.Id)){
                    Trello__c tc = IdVsTrello.get(con.Id);
                        tc.Name = IdVsCon.get(con.Id).LastName;
                        updateTrelloList.add(tc);
                   
                }
            }
        }
        system.debug('updaed list---->'+updateTrelloList);
        
        update  updateTrelloList;
        
     
        
    }
        
        
    }
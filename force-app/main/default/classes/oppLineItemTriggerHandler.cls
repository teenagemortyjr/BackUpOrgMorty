public class oppLineItemTriggerHandler {
    
    public static void q1(List<OpportunityLineItem> newOppLineItem){
        
        
        
        
        Set<Id> oppIdSet = new Set<Id>();
        List<Opportunity> opList = new List<Opportunity>();
        Map<Id,Id> opVsAc = New map<Id,Id>();
        List<Contact> newConList = new List<Contact>();
       // List<ContactLineItem> newConLineList = new List<ContactLineItem>();
        List<OpportunityContactRole> newConRole  = new List<OpportunityContactRole>();
        Map<Id,Id> conVsOppId = new Map<Id,Id>();
        
        
        
        
        for(OpportunityLineItem opLine: newOppLineItem){            
            oppIdSet.add(opLine.OpportunityId);   
        }
        
         opList = [Select Id, AccountId From Opportunity Where Id In: oppIdSet];
        
        for(Opportunity op: opList){
            
            if(!opVsAc.containsKey(op.Id)){
                opVsAc.put(op.Id,op.AccountId);
            }
        }
        
        
        for(OpportunityLineItem opLine: newOppLineItem){
            
            Contact con = new Contact();
            con.LastName = opLine.Name;
            con.AccountId = opVsAc.get(opLine.OpportunityId);
            newconList.add(con);
            conVsOppId.put(con.AccountId,opLine.OpportunityId);
            
        }
        
        insert newConList;
        
        system.debug('id--> '+newConList);
        
        
        for(Contact con: newConList){
            
            	OpportunityContactRole opConRole = new OpportunityContactRole();
            	opConRole.ContactId = con.Id;
            
            	opConRole.OpportunityId = conVsOppId.get(con.AccountId);
            	newconRole.add(opConRole);
        }
        
       	insert newConRole;
        
        
        
        
    } 

}
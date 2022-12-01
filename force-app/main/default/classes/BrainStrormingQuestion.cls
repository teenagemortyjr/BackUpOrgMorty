//--------------------
//   Name- Unknown
//   Question - BrainStorming Question
//   
//
//
//
//------------------


public class BrainStrormingQuestion {
    
    public static void createContactOnAccount(){
        List<Account> acList = [Select Id,Name From Account ];
         List<Contact> conList = new List<Contact>();
        
        for(Account a: acList){
            Contact con = new Contact(AccountId = a.Id, LastName='Account con',FirstName='Ac'+a.Name);
            system.debug('contact->'+con);
            conList.add(con);
        }
        
        Insert conList;
    }
    
    
    public static void q1(){
        
        
       Map<Id,Decimal> countryNameVsTotalPopulation = new Map<Id,decimal>();
       Map<Id,String> countryIdVsNameMap =  new Map<Id,String>();
       Map<Id,String> countryIdVsContinentNameMap = new  Map<Id,String>();
       Map<Id,Id> countryIdVsContinentIdMap = new Map<Id,Id>();
       Map<Id,Decimal> continentIdVSCountryPopulation = new Map<Id,Decimal>();
        
        
       List<States__c> stateList = [Select Id, Name,population__c,Countrie__c From  States__c Limit 50000];
       List<Countrie__c> countryList_c = [Select Id,Name,Continent__c From Countrie__c ];
       List<Continent__c> continentList = [Select Id,Name,totalcountries__c From Continent__c];
        
        
    
        
        
         for(Countrie__c c:countryList_c ){
            countryIdVsNameMap.put(c.Id,c.Continent__c);
               countryIdVsContinentIdMap.put(c.Id,c.Continent__c);
            
        }
        
        
         
        for(Continent__c c:continentList ){
            countryIdVsContinentNameMap.put(c.Id,c.Name);
            continentIdVSCountryPopulation.put(c.Id,c.totalcountries__c);
            
            
        }
        
        

       
        
        
        for(States__c s:stateList){
            
            
            if(countryNameVsTotalPopulation.containsKey(s.Countrie__c)){
                decimal currentPopulation = countryNameVsTotalPopulation.get(s.Countrie__c);
                
                currentPopulation = currentPopulation + s.population__c;
                countryNameVsTotalPopulation.put(s.Countrie__c,currentPopulation);
                
                
            }else{
                countryNameVsTotalPopulation.put(s.Countrie__c,s.population__c);
                
            }
            
            
        }
        
             system.debug('Here is current Map-->'+countryNameVsTotalPopulation);   
        
        
        
      
        List<Id> countryId = new List<Id>();
        List<Decimal> populationList = new List<Decimal>();
      
                
        
        
        for(Id i:countryNameVsTotalPopulation.keySet()){
            countryId.add(i);
        }
        
        system.debug('here is id-->'+countryId);
        
        for(Id i: countryId){
            
            populationList.add(countryNameVsTotalPopulation.get(i));
            
        }
        
        system.debug('here is populatoin list-->'+populationList);
        
        
        
        //bubble sort login
        
        for(Integer i=0;i<populationList.size()-1;i++){
            
            for(Integer j=0;j<populationList.size()-i-1;j++){
                
                
                if(populationList[j+1]>populationList[j]){
                    
                    decimal temp = populationList[j];
                    populationList[j] = populationList[j+1];
                    populationList[j+1] = temp;
                    
                    
                    Id tempId = countryId[j];
                    countryId[j] = countryId[j+1];
                    countryId[j+1] = tempId;
                    
                    
                }
                
            }
        }
        
        
        system.debug('new countryList-->'+countryId);
        system.debug('new population LIst-->'+populationList);
        
        
        
        for( Id c:countryId ){
            
            
            system.debug(countryIdVsContinentNameMap.get(countryIdVsContinentIdMap.get(c))+' -> '+continentIdVSCountryPopulation.get(countryIdVsContinentIdMap.get(c))+'-> '+countryNameVsTotalPopulation.get(c));
            
            
        }
        
        
       
        
    }
    
    
    public static void q2(){
        
        Date currentDate = Date.today();
        Date dateBetweenNext30 = currentDate.addDays(30);
       	Decimal totalAmount = 0;
        
		List<OpportunityLineItem> opLineItemList = [Select Id,OpportunityId,Quantity From OpportunityLineItem Where Quantity>50];
        system.debug('opplineItem --> '+opLineItemList);
        
        set<Id> oppId =  new set<Id>();
        
        for(OpportunityLineItem opItem: opLineItemList ){
            
            oppId.add(opItem.OpportunityId);
        }
        
        system.debug('Here is opID--->'+oppId);
        
        List<Opportunity> opList = [Select Id,Amount,CloseDate From Opportunity 
                                    Where (CloseDate >:currentDate and CloseDate <:dateBetweenNext30) And Id=:oppId];
        
        system.debug('Here is opportuntiyList-->'+opList);
        
        for(Opportunity op: opList){
            
            if(op.Amount != null){
                
                totalAmount = totalAmount + op.Amount;
                
            }
        }
        
        system.debug('Here is total Amount'+totalAmount);
        
        
    }
    
    public static void q3(){
        
        List<Opportunity> opList = [Select Id,AccountId,StageName From Opportunity Where StageName='Closed Won' or StageName='Closed Lost'];
        system.debug('Opportunity List -->'+opList);
        
      	List<Id> accountId = new List<Id>();
        List<Id> oppId = new List<Id>();
        Set<Id> conId = new Set<Id>();
           
        Map<Id,String> opIdVsAcIdMap = new Map<Id,String>{};
        Map<Id,List<String>> opIdVsConNameMap = new Map<Id,List<String>>{};
        Map<Id,String> acIdVsAcNameMap = new Map<Id,String>{};
          Map<Id,String> opIdVsAcNameMap = new Map<Id,String>{};
               Map<Id,List<Id>> opIdVsConIdListMap = new Map<Id,List<Id>>{};
            
                  

		
            
      
        
        for(Opportunity op: opList){
            accountId.add(op.AccountId);
            oppId.add(op.Id);
            
            opIdVsAcIdMap.put(op.Id,op.AccountId);
        }
        system.debug('oppId'+oppId);
	        
        List<Account> accountList = [Select Id,Name From Account Where Id In :accountId];
        List<OpportunityContactRole> opConRoleList = [Select Id,ContactId,OpportunityId From
                              
                                                      OpportunityContactRole];

        system.debug('oppconroleList-->'+opConRoleList);
        for(Account ac: accountList){
            acIdVsAcNameMap.put(ac.Id,ac.Name);
        }
        
       
        
		        
        for(OpportunityContactRole op: opConRoleList){
            
            conId.add(op.ContactId);
           
            
        }
        system.debug('conList-->'+conId);
        
       for(Opportunity op: opList){
           
           opIdVsAcNameMap.put(op.Id,acIdVsAcNameMap.get(opIdVsAcIdMap.get(op.Id)) );
        }
        
        system.debug('opIdvsAcNameMap-->'+opIdVsAcNameMap);
        
        List<Contact> conlist = [Select Id,FirstName,LastName From Contact Where Id In:conId ];
        system.debug('conList-->'+conList);
        Map<Id,String> conIdVsConNameMap = new Map<Id,String>{};
        
            for(Contact con: conList){
                String name = con.FirstName +' '+con.LastName;
                conIdVsConNameMap.put(con.Id,name);
            }
        
        system.debug('conIdVsConNameMap---->'+conIdVsConNameMap);
        
        		        
        for(OpportunityContactRole op: opConRoleList){
            
         if(opIdVsConNameMap.containsKey(op.OpportunityId)){
            opIdVsConNameMap.get(op.OpportunityId).add(conIdVsConNameMap.get(op.ContactId));
                }else{
                    
                    opIdVsConNameMap.put(op.OpportunityId, new List<String>{conIdVsConNameMap.get(op.ContactId)});
                    
                }
        
            
        }
        
      system.debug('opIdVsConIdListMap--->'+opIdVsConIdListMap);
           
        
        
        system.debug('Account List-->'+accountList);
        system.debug('Contact List-->'+opConRoleList);
        
        
        
        for(Opportunity op: opList){
            
            
            String name  = opIdVsAcNameMap.get(op.Id);
            if(name != null && opIdVsConNameMap.get(op.Id).size()>0){
            for(String s:  opIdVsConNameMap.get(op.Id) ){
                if(s != null){
                if(name == s ){
                    system.debug('opportuntiy Name is-->'+op.Name);
                    break;
                }
                }
            }
            
            
        
        }
        }
   
            
        
     
        
        
        
        
    }
    
    
    public static void q6(){
        
        List<Contact> conList = [Select Id,Name,AccountId From Contact Where AccountId != Null];
        
        Map<Id,Integer> accIdVsConList = new map<Id,Integer>();
        
        
        for(Contact con: conList){
            
            if(accIdVsConList.containsKey(con.AccountId)){
                
               Integer count =  accIdVsConList.get(con.AccountId) + 1;
                accIdVsConList.put(con.AccountId,count);
                
            }else{
                accIdVsConList.put(con.AccountId,1);
                
            }
            
        }
        
        system.debug('account---map-->'+accIdVsConList);
        
    }
    
    

}
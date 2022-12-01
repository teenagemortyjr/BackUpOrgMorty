public class TestQ {
    
    public  static SObject getNewSobject(String t) {
    
        /* Call global describe to get the map of string to token. */
        Schema.SObjectType accountType = Schema.getGlobalDescribe().get('Account');
        system.debug('Account type---->'+accountType);

        SObject newAccount = accountType.newSObject();
                 system.debug('newAccount-->'+newAccount);
        
        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        
        /* Get the token for the sobject based on the type. */
        Schema.SObjectType st = gd.get(t);
        System.assert(st != null,'Type provided: "' + t + '" doesnt map to an sobject token in this org.');
        
        /* Instantiate the sobject from the token. */
        Sobject s = st.newSobject();
       
        
        return s;
    }
    
    public static  void insertData(){
        Sobject s  =  getNewSobject('Account');
    
        
        
    }
    
    
      
     @AuraEnabled
    public static void loadData(String objectName ) {

        SObjectType objToken = Schema.getGlobalDescribe().get(objectName);
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap(); 
        
        Set<String> fieldSet = fields.keySet();
        for(String s:fieldSet)
        {
            SObjectField fieldToken = fields.get(s);
            DescribeFieldResult selectedField = fieldToken.getDescribe();
            System.debug(selectedField.getName());
        }
    }
    
    
    public static  void q1(){
        
        List<Account> acList =  [Select Id ,StartDate__c, EndDate__c From Account Where Id!= null];
        List<Contact> conList = [Select Id,Name,StartDate__c,EndDate__c,AccountId From Contact Where AccountId In: acList];
        List<Account> updateAcList = new List<Account>();
        Map<Id,List<Contact>> IdVsCon = new Map<Id,List<Contact>>();
        
        
        for(Contact con: conList){
            if(IdVsCon.containsKey(con.AccountId)){
                
                IdVsCon.get(con.AccountId).add(con);
                
            }else{
                IdVsCon.put(con.AccountId,new List<Contact>{con});
            }
            
        }
        
        
        for(Account ac :acLIst){
            
            if(IdVsCon.containsKey(ac.Id)){
                Integer diff = null;
                Date sdate = null;
                Date eDate = null;
                
                
                for(Contact con :IdVsCon.get(ac.Id)){
                    
                    if(diff == null){
                        
                        if(con.StartDate__c !=null && con.EndDate__c != null){
                             diff =  con.StartDate__c.daysBetween(con.EndDate__c);   
                             sDate = con.StartDate__c;
                             eDate = con.EndDate__c;
                        }
                    }else{
                        
                        Integer tempDiff = con.StartDate__c.daysBetween(con.EndDate__c);
                        if(tempDiff<diff){
                             sDate = con.StartDate__c;
                             eDate = con.EndDate__c;
                             diff = tempDiff;
                      }
                        
                      }
                    
                    
                    
                }
                
                if(sDate != null && eDate != null){
                    
                    ac.StartDate__c = sDate;
                    ac.EndDate__c = eDate;
                    updateAcList.add(ac);
                    
                    
                }
            }
            
            
        }
        update updateAcList;
     
        
    }

}
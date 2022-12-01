public class CreateAccountApex {
    
    @AuraEnabled
    public static void changeOppCloseDate(Id oppId,Date newDate){
        
        system.debug('iosfosjof');
        system.debug('date is-->'+newDate);
        
        
        List<Opportunity> opList = [Select Name,CloseDate From Opportunity Where Id=:oppId Limit 1];
        system.debug('oppList-->'+opList);
        
        for(Opportunity op: opList){
            op.CloseDate = newDate;
        }
        
        system.debug('after update-->'+opList);
        
        update opList;
        
    }
    
    @AuraEnabled
    public static List<Opportunity> showOppData(Id oppId){
        
        return([Select Id,Name,CloseDate,StageName From Opportunity Where Id =:oppId Limit 1]);
        
        
    }
    
    @AuraEnabled
    public static List<Opportunity> showOppList(){
        
        return([Select Name,Id From Opportunity Where Name!=null Limit 50000]);
    }
    
    
   // public WrapperConOpp conOppWrap{get;set;}
       
    public class WrapperConOpp{
          @AuraEnabled
        public List<String> conList  {get;set;}
          @AuraEnabled
        public List<String> oppList  {get;set;}
    }
    
    
    
    
    @AuraEnabled
    public static List<Account> accList(){
        
        return ([Select Name,Id From Account Where Name!=null Limit 50000]);
    }
    
    
    
    @AuraEnabled
    public static WrapperConOpp showContactOpp(Id acId){
        
         WrapperConOpp  conOppWrap = new WrapperConOpp();

       // List<String> conListName = new List<String>();
        List<Contact> conList = [Select Name,AccountId From Contact Where AccountId=:acId Limit 50000];
        
        List<String> stringList = new List<String>();
         List<String> oppList1 = new List<String>();
        for(Contact con: conList){
            if(con.Name!=null){
                stringList.add(con.Name);
            //conOppWrap.conList.add(con.Name);
            }
        }
        
        List<Opportunity> oppList = [Select Name,AccountId From Opportunity Where AccountId=:acId Limit 50000];
        
        
        for(Opportunity op: oppList){
            if(op.Name!=null){
                oppList1.add(op.Name);
           
            }
        }
        system.debug('account con opp list -->'+conOppWrap);
        conOppWrap.oppList = oppList1;
             conOppWrap.conList = stringList;
            
        return conOppWrap;
        
      
        
    }
    
     @AuraEnabled
     public static List<String> showOpp(Id acId){
        
        List<String> oppListName = new List<String>();
        List<Opportunity> oppList = [Select Name,AccountId From Opportunity Where AccountId=:acId Limit 50000];
        
        
        for(Opportunity op: oppList){
            
            oppListName.add(op.Name);
        }
        
        return oppListName;
        
    }
    
    @AuraEnabled
    public static void insertAccount(String accountName,String accountNumber,String phoneNumber,String Rating,Integer noOfEmp){
        List<Account> acList = new List<Account>();
        
 		Account ac = new Account();
        ac.Name = accountName ;
       	ac.Phone = phoneNumber;
        ac.AccountNumber = accountNumber;
        ac.Rating = rating;
        ac.NumberOfEmployees = noOfemp;
        
        acList.add(ac);
        
        Insert acList;
        
       
        
        
    }

}
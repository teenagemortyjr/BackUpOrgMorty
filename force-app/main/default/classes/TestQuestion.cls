public class TestQuestion {
    
    public static void q13(){
        
        
        List<Account> acclist = new List<Account>();
        List<OrderItem> olilist = new List<OrderItem>();
        Map<Id,List<OrderItem>> mapoli = new Map<Id,List<OrderItem>>();
        acclist = [select Id,OrderDate__c,total_Amount__c,	Quantity__c,Product_Name__c from Account];
        olilist = [select Id,Quantity,OrderId,Order.AccountId,Order.TotalAmount,Order.EffectiveDate from OrderItem where Order.AccountId In :acclist];
        
        for(OrderItem oli : olilist){
            if(!mapoli.containsKey(oli.Order.AccountId)){
                mapoli.put(oli.Order.AccountId,new List<OrderItem>{oli});
            }else{
                mapoli.get(oli.Order.AccountId).add(oli);
            }
        }
       
        for(Account acc : acclist){
            if(mapoli.containskey(acc.Id)){
                for(OrderItem oli : mapoli.get(acc.Id)){
                    acc.Product_Name__c = acc.Product_Name__c == null? oli.Product2.Name : acc.Product_Name__c + oli.Product2.Name;
                    acc.Quantity__c = acc.Quantity__c == null? (oli.Quantity) : acc.Quantity__c + (oli.Quantity);
                    acc.total_Amount__c = acc.total_Amount__c == null? String.valueOf(oli.Order.TotalAmount) : acc.total_Amount__c + String.valueOf(oli.Order.TotalAmount);
                    acc.OrderDate__c = acc.OrderDate__c == null? String.valueOf(oli.ServiceDate) : acc.OrderDate__c + String.valueOf(oli.ServiceDate);
                }
            }
        }
        system.debug('here is the list -->'+accList);
        
        if(!acclist.isEmpty()){
            update acclist;
        }
        
        
    }
    /*
    public static void q12(){
        List<Account> acList = [Select Id,Name, Quantity__c,Product_Name__c,OrderDate__c,Total_Amount__c From Account,Name != null];
        
        Map<Id,String> IdVsString = new Map<Id,String>();
        Map<Id,List<Id>> IdVsIdList = new Map<Id,List<Id>>();
        List<Opportunity> oppList = [Select Id,AccountId From Opportunity Where AccountId In: acList];
        
        for(Opportunity op: oppList){
            
            if(IdVsIdList.containsKey(op.AccountId)){
                
                IdVsIdList.get(op.AccountId).add(op.Id);
            }else{
                IdVsIdList.put(op.AccountId,new List<Id>{op});
            }
        }
        List<OpportunityLineItem> opLineItemList = [Select Id,OpportunityId From OpportunityId];
        
        for(OpportunityLineItem opLine: opLineItemList){
            
            
            
            
        }
        
    }
*/
    
    public static void q11(){
        
        Player__c p = new Player__c(Name = 'Sagar', Type__c = 'All Rounder',Jersey_number__c = 1023);
        insert p;
        
        Team__c t = new Team__c(Name ='TeamIndia',Contry__c='India',Long_url__c='www.teamIndia.com');
        
        insert t;
        
        Playing_Eleven__c pE = new Playing_Eleven__c(Is_Capton__c = true, Name = '404', Team__c = t.Id, Player__c = p.Id );
        
        insert pE;
       
        
        
    }
    
    public static void q10(){
        
        
       	List<Building__c> buildingList = [Select Id,Name ,Floor_No__c,No_Of_Unit__c From Building__c Where Id!= null];
        system.debug(buildingList);
        List<Flat__c> flatList = new List<Flat__c>();
        
        
        for(Building__c b: buildingList){
            
            Decimal defaultFlat = 100;
            Decimal noOfFlor = b.Floor_No__c;
            Decimal noOfUnits = b.No_Of_Unit__c;
            Decimal FlorNo = 100;
            
            
            while(noOFFlor>0){
                
                noOfFlor--;
                FlorNo = defaultFlat;
                
                for(Decimal i = 0 ; i<noOfUnits;i++){
                    	 
                    
                    	Flat__c f = new Flat__c(Name = FlorNo+b.Name,Building__c = b.Id);
                    	system.debug('float -->'+f);
                    FlatList.add(f);
                    FlorNo++;   	
              		  }
                defaultFlat = defaultFlat + 100;
            }
            
            
            
            
            
        }
        
        system.debug(FlatList);
        
        insert FlatList;
        
        
        
        
        
    }
    
    
    
    public static void q9(){
        
        Date tempDate = date.today().addDays(30);
        Date todayDate = date.today();
        Map<Id,Decimal> IdVsCount = new Map<Id,Decimal>();
        List<OpportunityLineItem> opLineList = new List<OpportunityLineItem>();
        
        List<Opportunity> oppList = [Select Id, Name , CloseDate From Opportunity Where CloseDate> :todayDate and closeDate < :tempDate];
        
        opLineList = [Select Id, Quantity, OpportunityId From OpportunityLineItem Where OpportunityId In :oppList];
        
        for(OpportunityLineItem opLine: opLineList){
            
            if(IdVsCount.containskey(opLine.OpportunityId)){
                Decimal tempQnt = IdVsCount.get(opLine.OpportunityId) + opLine.Quantity;
                IdVsCount.put(opLine.OpportunityId,tempQnt);
                
            }else{
                
                IdVsCount.put(opLine.OpportunityId,opLine.Quantity);
            }
            
        }
        
        
        for(Opportunity op: oppList){
            
            if(IdVsCount.containsKey(op.Id)){
                If(  IdVsCount.get(op.Id)>50){
                    system.debug(op.Name+'----->'+IdVsCount.get(op.Id));
                }
            }
        }
        
        //system.debug('opplist is-->'+oppList);
        
    }
    
    public static void q8(){
        
        List<Account> acList = [Select Name,Id, Working_in__c From Account Where Working_in__c = 'ASIA'];
        system.debug('account List'+acList);
        Map<Id,Decimal> opIdVsQuantity = new map<Id,Decimal>() ;
        Map<Id,List<Id>> IdVsId =  new Map<Id,List<Id>>();
        
        List<Opportunity> oppList = [Select Id , AccountId From Opportunity Where AccountId In :acList];
        system.debug('opportunity---->'+oppList);
        for(Opportunity op: oppList){
            
            if(!IdVsId.containskey(op.AccountId)){
                IdVsId.put(op.AccountId,new List<Id>{op.Id});
            
            }else{
                IdVsId.get(op.AccountId).add(op.Id);
            }
        }
        
        List<OpportunityLineItem> oppLineList =  [Select Id , OpportunityId , Quantity From OpportunityLineItem Where OpportunityId In :oppList];
        
        for(OpportunityLineItem opLine: oppLineList){
            
            if(opIdVsQuantity.containsKey(opLine.OpportunityId)){
                Decimal tempQnt = opIdVsQuantity.get(opLine.OpportunityId);
                tempQnt = tempQnt+ opLine.Quantity;
                opIdVsQuantity.put(opLine.OpportunityId,tempQnt);
            }else{
                opIdVsQuantity.put(opLine.OpportunityId,opLine.Quantity);
            }
        }
        
        
        for(Account ac: acList){
            
            if(IdVsId.containsKey(ac.Id)){
                Decimal totalQuantity = 0;
                
                
                for(Id op: IdVsId.get(ac.Id)){
                    if(opIdVsQuantity.containskey(op)){
                        
                         totalQuantity = opIdVsQuantity.get(op) + totalQuantity;
                    
                           }
                			}
                
                
              				 System.debug(ac.Name +'-----'+totalQuantity);
              
                
            }
        }
        
        
        system.debug('oppList with Quantity'+oppLineList);
        
        
        
        
    }
    
    public static void q7(){
        
       List<Receivables__c> recList = [Select Id , Financial_Account__c , Total_Amount__c From 	Receivables__c];
       Set<Id> finSet = new Set<Id>();
       Map<Id,Decimal> finIdVsInt = new Map<Id,Decimal>();
       List<Financial_Account__c> fAcList = new List<Financial_Account__c>();
       
        
        for(Receivables__c r: recList){
            
            finSet.add(r.Financial_Account__c);
            
            if(finIdVsInt.containskey(r.Financial_Account__c)){
                
                Decimal tempTotal = finIdVsInt.get(r.Financial_Account__c);
                tempTotal = tempTotal + r.Total_Amount__c;
                
                finIdVsInt.put(r.Financial_Account__c,tempTotal);
                
            }else{
                
                finIdVsInt.put(r.Financial_Account__c, r.Total_Amount__c);
            }
        }
        
        
        fAcList = [Select Id, Total_Fees__c From  Financial_Account__c Where Id In:finSet];
        
        
        for(Financial_Account__c f: fAcList){
            
            
            if(finIdVsInt.containsKey(f.Id)){
                
                f.Total_fees__c = finIdVsInt.get(f.Id);
            }
            
            
        }

		update fAcList;        
        
        
        
       
      	
        
       
        
        
        
    }
    
    public static void q6(){
        system.debug('it will do nothing..');
        
        /*
        List<Contact> conList = [ Select Id, Name , AccountId From Contact ];
        List<OpportunityContactRole> opConRoleList = [Select Id, Name, ContactId, OpportunityId From OpportunityContactRole];
        system.debug('contact list --->'+conList);
       Map<Id,List<Contact>> acIdVsConList = new Map<Id,List<Contact>>();
        
        
       for(Contact con: conList){
            
            if(acIdVsConList.containsKey(con.AccountId)){
                acIdVsConList.get(con.AccountId).add(con);
            }else{
                acIdVsConList.put(con.AccountId,new List<Contact>{con});
            }
            
   
        }
        
        
        
        
        */
        
    }
    
    public static void q5(){
        
        List<Actor__c> mainActorList = [Select Name, Account_Name__c From Actor__c  Where Name like 'a%' or Name like 'd%'];
        set<Id> acSet = new set<Id>();
        List<Account> acList = new List<Account>();
        system.debug('actor names started with A and C'+mainActorList);
        
        
        
        for(Actor__c a: mainActorList){
            
            acSet.add(a.Account_Name__c);
            
        }
        
        acList = [Select Id, Total_Rating__c From Account Where Id In:acSet];
        
        
        List<Actor__c> actorList = [Select Name, Account_Name__c , Rating__c From Actor__c Where Rating__c >=10];
        system.debug('actor name are here'+actorList);
        Decimal totalRating = 0;
        
        for(Actor__c a: actorList){
            
            totalRating = totalRating +  a.Rating__c;
            
        }
        
        for(Account ac : acList){
            ac.Total_Rating__c = totalRating;
        }
        
        update acList;
        
        
        
        
        
    }
    
    
    public static void q4(){
        
        List<Contact> conList = [Select Id, Name ,MailingCity,MailingCountry,MailingState,MailingPostalCode,MailingStreet,MailingAddress, AccountId From Contact];
        Map<Id,List<Contact>> acVsConList = new Map<Id,List<Contact>>();
        Set<Id> acSet = new Set<Id>();
        List<Account> acList = new List<Account>();
        
        for(Contact con: conList){
            acSet.add(con.AccountId);
            
            if(acVsConList.containsKey(con.AccountId)){
                
                    acVsConList.get(con.AccountId).add(con);
                
            }else{                
                
            		acVsConList.put(con.AccountId, new List<Contact>{con});
            }
        }
        
        acList = [Select Id,Name,BillingCity,BillingCountry,BillingPostalCode ,BillingStreet,BillingAddress From Account Where Id In:acSet];
        
        
        for(Account ac: acList){
            
            if(acVsConList.containsKey(ac.Id)){
                
                Contact con = acVsConList.get(ac.Id)[Integer.valueof((Math.random() * acVsConList.get(ac.Id).size()-1))];
               	List<String> conName = con.Name.split('');
                system.debug('name is here---->'+conName);
                
                if(conName[0] == 'C' || conName[0] == 'A' || conName[0] == 'c' || conName[0] == 'a'){
                    
                    if(ac.BillingAddress != null){
                        ac.BillingCity = con.MailingCity;
                        ac.BillingCountry = con.MailingCountry;
                        ac.BillingState =  con.MailingState;
                        ac.BillingStreet = con.MailingStreet;
                 
                    }
                    
                }
                ac.Name = con.Name;
              
            }
        }
        
        update acList;
    }
    
    
    
    
    
    public static void q3(){
        
  List<Contact> conList = [Select Id,Account.Name, AccountId From Contact Where Account.Name != null];
  Map<String,Integer> AcNameVsInteger = new Map<String,Integer>();
  List<Account> acList = [Select Id, Name From Account Where Id != null];
  List<AccountCon__c> acCount  = new List<AccountCon__c>();

for(Contact con: conList){
    
    if(AcNameVsInteger.containsKey(con.Account.Name)){
        Integer count = AcNameVsInteger.get(con.Account.Name);
        count++;
        
        AcNameVsInteger.put(con.Account.Name,count);
    }else{
        AcNameVsInteger.put(con.Account.Name,1);
    }
}

for(Account ac: acList){
    
    if(AcNameVsInteger.containskey(ac.Name)){
        
        AccountCon__c acCon = new AccountCon__c(Name = ac.Name,Number_of_Contacts__c=  AcNameVsInteger.get(ac.Name));
        acCount.add(acCon);
    }
}

insert acCount;






    }
    public static void q2(){
        
       List<Contact> conList = [Select Id,AccountId,MailingStreet,MailingCity, MailingAddress,Copy_address_to_contact__c  From Contact Where Copy_address_to_contact__c = true];
       Set<Id> acSet = new Set<Id>();
       Map<Id,Id> conVsAc = new Map<Id,Id>();
       Map<Id,Account> IdVsAdd = new Map<Id,Account>();
        
       
        
        for(Contact con: conList){
            
            acSet.add(con.AccountId);
        }
        
        List<Account> acList = [Select Id , BillingAddress,BillingStreet,BillingCity From Account  Where Id In :acSet];
        
        for(Account ac: acList){
            
            if(ac.BillingAddress != null){
                IdVsAdd.put(ac.Id,ac);
            }
           
        }
        
        for(Contact con: conList){
            if(IdVsAdd.get(con.AccountId) != null){
            Account ac = IdVsAdd.get(con.AccountId);
                
             con.MailingStreet     = ac.BillingStreet;
             con.MailingCity       = ac.BillingCity;
           
                
                }
        }
        
        update conList;
        
        
        
        
        
        
    }
    
    public static  void q1(){
        List<Employee__c> empList = [Select Id, Company__c, Gender__c From Employee__c];
        Set<Id> comSet = new Set<Id>();
        List<Company__c> comList = new List<Company__c>(); 

        //             Map---<Male,Female>
        Map<Id,List<Integer>>  comVsCount = new Map<Id,List<Integer>>();
     
        for(Employee__c e: empList){
            
            
            if(ComVsCount.containsKey(e.Company__c)){
                System.debug('e.Gender__c--'+e.Gender__c);
                if(e.Gender__c == 'Male'){
                    System.debug('Map -->'+ComVsCount.get(e.Company__c));
                   Integer m =  ComVsCount.get(e.Company__c)[0];
                    System.debug('m before increament-->'+m);
                    m++;
                    System.debug('m after increament-->'+m);
                    ComVsCount.get(e.Company__c)[0] = m;
                    System.debug('m ComVsCount-->'+ComVsCount);
                    
                }else{
                    System.debug('Map -->'+ComVsCount.get(e.Company__c));
                    Integer f =  ComVsCount.get(e.Company__c)[1];
                    System.debug('f before increament-->'+f);
                    f++;
                    System.debug('f after increament-->'+f);
                    ComVsCount.get(e.Company__c)[1] = f;
                    
                    System.debug('f ComVsCount-->'+ComVsCount);
                    
                    
                }
            }else{
                System.debug('e.Gender__c --'+e.Gender__c +' -e --'+e);
                if(e.Gender__c == 'Male'){
                ComVsCount.put(e.Company__c,new List<Integer>{1,0});
                }else{
                   
                     ComVsCount.put(e.Company__c,new List<Integer>{0,1});
                    
                    system.debug('Map-->'+ComVsCount);
                }
                system.debug('list --->'+ComVsCount.get(e.Company__c));
            }
                    
            comSet.add(e.Company__c);

           
        }
        

        
        
        comList = [Select Id , Male_Employee__c , Female_Employee__c From Company__c Where Id In:comSet];
        system.debug('comList-->'+comList);
        for(Company__c  c: comList){
           
            if(ComVsCount.containsKey(c.Id)){
                
                c.Male_Employee__c = ComVsCount.get(c.Id)[0];
                c.Female_Employee__c = ComVsCount.get(c.Id)[1];
            }
            
            
        }
        
        
        update comList;
        
    }

}
@isTest
public class OpportunityContactRoleTriggerTest {
    
    @isTest
    public static void simpleTest(){
        
        List<Opportunity> opList = new List<Opportunity>();
        
        Opportunity op = new Opportunity();
        op.Name = 'randomOpp';
        op.CloseDate = date.today();
        op.StageName = 'Prospecting';
        opList.add(op);
        insert opList;
        
        Product2 p = new Product2(Name='dump23');
        insert p;
        
        Pricebook2 stdPriceBook = new Pricebook2(IsActive=true,Id =Test.getStandardPricebookId());
        update stdPriceBook;
        
       
        
        //Contact c = new Contact(LastName='jojo');
        //insert c;
        
     
        
        PricebookEntry p3 = new PricebookEntry(Pricebook2Id = stdPriceBook.Id,Product2Id=p.Id,UnitPrice=20.0,IsActive=true);
       	system.debug('here is pricebookEntry --->'+p3);
        insert p3;
        system.debug('here is pricebookEntry --->'+p3);

        
        
        
        OpportunityLineItem opLine  = new OpportunityLineItem(OpportunityId = op.Id,Product2Id = p.Id,PricebookEntryId=p3.Id,Quantity=2,TotalPrice=1000);
		insert opLine;
        system.debug('this is opportunity list-->'+opList);
        /*
        List<OpportunityContactRole> opConRoleList = new List<OpportunityContactRole>();
        
        for(Opportunity o: opList){
            
        OpportunityContactRole opConRole = new OpportunityContactRole(OpportunityId = o.Id,ContactId =c.Id);
            opConRoleList.add(opConRole);
        }
        insert opConRoleList;*/
    }

}
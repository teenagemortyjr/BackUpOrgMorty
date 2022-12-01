public class ClickbuttonApex {
    
    
    @AuraEnabled
    public static void insertCount(Integer count){
        
        system.debug('i am being called');
        List<Count__c> countList = [Select 	CurrentValue__c  From Count__c];
        
        if(!countList.isEmpty()){
            
            countList[0].CurrentValue__c = 1 +   countList[0].CurrentValue__c;
            update countList;
        
        }else{
            
            Count__c c = new Count__c(Name='current Count',CurrentValue__c = count);
            countList.add(c);
             insert countList;
        }
        
        system.debug('here is the list-->'+countList);
       
        
     
        
        
    }

}
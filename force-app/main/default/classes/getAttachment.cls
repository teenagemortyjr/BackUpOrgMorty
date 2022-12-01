public class getAttachment {
    
    public static void getList(){
        
    List<Id> ids = new List<Id>();

        for(Account ac:[Select Id From Account Limit 50000]){
            
            ids.add(ac.Id);
        }
        system.debug('Id is-->'+ids);
        

List<ContentDocument> attachments = [SELECT Id ,Title FROM ContentDocument ];
	system.debug('list is here-->'+attachments);
 
    }
}
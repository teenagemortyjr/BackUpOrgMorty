public class Accontinsert 
{
    

    @AuraEnabled
    public static string deleteMethod(string Apexname){
        list<account> listaccount = [Select Name From Account Where Name =:Apexname];
        system.debug('IM IN APEX ++++'+listAccount);
        string name = listaccount[0].name;
        delete listaccount;
        system.debug('Account has been deleted');
        return name;      
    }
    
    @AuraEnabled
    public static void InsertMethod(string Apexname,Integer NoOfAc){
        List<Account> listaccount = new List<Account>();
        system.debug('IM IN APEX  account creating++++');
        
        for(Integer i=0;i<NoOfAc;i++){
        Account ac  = new Account();
        ac.Name = Apexname+i;
        listaccount.add(ac);  
        }
        Insert listaccount;
        system.debug('Account has Created deleted');
        
      
    }
    
    
    
    
}
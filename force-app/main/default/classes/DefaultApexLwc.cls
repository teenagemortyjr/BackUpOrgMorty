public class DefaultApexLwc {
    

@AuraEnabled(cacheable=true)

        public static List<Account> getAccount(){

            List<Account> acList = new List<Account>();
            aclist = [Select Id,Name From Account Limit 50000];
            return acList;
        }


        @AuraEnabled(cacheable=true)
        public static List<Contact> getContact(String accId){
                List<Contact> conList =  [Select Id,LastName,AccountId From Contact Where AccountId=:accId Limit 50000];
                return conList;
        }

    
}
public class defaultApex {

    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> getOpportunityLineItem(string accountId){

        List<OpportunityLineItem> oppLineItemList = [Select Id,Name,ProductCode,Quantity,TotalPrice ,opportunityId  From OpportunityLineItem Where opportunity.AccountId=:accountId ];
        return oppLineItemList;
    }


    @AuraEnabled
    public static List<sObject> search(String searchTerm, string myObject, String filter) {
        String myQuery = null;
        system.debug(searchTerm);
        system.debug(myObject);
        system.debug(filter);
        if(filter != null && filter != ''){
            myQuery = 'Select Id, Name from '+myObject+' Where Name Like  \'%' + searchTerm + '%\' AND '+filter+' LIMIT  5';
        }
        else {
            if(searchTerm == null || searchTerm == ''){
                myQuery = 'Select Id, Name from '+myObject+' Where LastViewedDate != NULL ORDER BY LastViewedDate DESC LIMIT  5';
            }
            else {
                myQuery = 'Select Id, Name from '+myObject+' Where Name Like  \'%' + searchTerm + '%\' LIMIT  5';
            }
        }
        List<sObject> lookUpList = database.query(myQuery);
        
        return lookUpList;
    }

    @AuraEnabled(cacheable = true)
    public static boolean checkForBanner(string accountId,String opportunityId){

        Boolean isShowBannerTrue = false;
        Boolean isQuantityValueMoreThan50000 = false;

        List<Account> accList = [Select Id,	showBanner__c From Account Where Id=:accountId];
        List<OpportunityLineItem> oppLineItemList = [Select Id,opportunityId,Quantity From OpportunityLineItem Where opportunityId=:opportunityId and Quantity >5000 ];

            system.debug('Account-->'+accList);
            system.debug('oppLineItemList-->'+oppLineItemList);
        if(oppLineItemList.size()>0){
            isQuantityValueMoreThan50000 = true;
            system.debug('inside oppLineItemList '+isQuantityValueMoreThan50000);

        }

        for(Account ac: accList){
            if(ac.showBanner__c == true){
                isShowBannerTrue = true;
            }
        }
        

        return (isShowBannerTrue && isQuantityValueMoreThan50000);


    }
    

    @AuraEnabled(cacheable=true)
        public static boolean isNumberOfContactMoreThan5(){
            List<Contact> conList = [Select Id,Name,Show_Banner__c From Contact];

            Boolean isSizeMoreThan5 = false;
            Boolean isShowBannerTrue = false;

            if(conList.size()>5){
                isSizeMoreThan5 = true;

            }

            for(Contact con: conList){
                if(con.Show_Banner__c == True){
                    isShowBannerTrue = true;
                    break;
                }

            }

            return (isSizeMoreThan5 && isShowBannerTrue);


        }

        @AuraEnabled(cacheable=true)
        public static List<Account> getAccountList() {
            return [SELECT Id, Name, Industry, NumberOfEmployees FROM Account Where Industry != null WITH SECURITY_ENFORCED LIMIT 100];
        }
    

      @AuraEnabled(cacheable=true)
    public static List<Account> allAccountWithContact(){

        return [ Select Id,Name,Phone, Website ,(Select Id,Name,Phone,Email From Contacts) From Account  ];

    }


    @AuraEnabled 
    public static List<Contact> getContactsController(){

        return [SELECT Id, FirstName, LastName FROM Contact Where FirstName != null LIMIT 1000];

    }


    public class  loadDataWrapper{
        
        @AuraEnabled
        public String headerList;
        @AuraEnabled
        public String getMsg;
    }


    public SObject getNewSobject(String objectName) {
    
        /* Call global describe to get the map of string to token. */
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        
        /* Get the token for the sobject based on the type. */
        Schema.SObjectType st = gd.get(objectName);
        System.assert(st != null,'Type provided: "' + objectName + '" doesnt map to an sobject token in this org.');
        
        /* Instantiate the sobject from the token. */
        Sobject s = st.newSobject();
      
        return s;
    }
    
   






    @AuraEnabled
    public static loadDataWrapper loadData( Id contentDocumentId ) {

        loadDataWrapper lWrap = new loadDataWrapper();

        String strMessage;
        List <Account> contactList = new List <Account>();

        

        if ( contentDocumentId != null ) {
            ContentVersion contentVersionObj = [ SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:contentDocumentId ];
            List <String> records = contentVersionObj.VersionData.toString().split('\n');
            system.debug('All Header -->'+records);
            lWrap.headerList = records[0];
            //Removing the Header
            records.remove(0);
            system.debug('after removing header-->'+records);

            for ( String record : records ) {

                if ( record != null ) {

                    Account objContact = new Account();
                    List < String > row = record.split( ',' );
                    objContact.Name = row[ 0 ];
                    objContact.Site = row[ 1 ];
                    objContact.AccountSource = row[ 2 ];
                    contactList.add( objContact );

                }

            }
            try {    

                if ( contactList.size() > 0 ) {

                    Database.DeleteResult deleteResult = Database.delete( contentDocumentId, true );
                    insert contactList;
                    lWrap.getMsg  = 'Records loaded successfully';
                }

            }
            catch ( Exception e ) {

                lWrap.getMsg = 'Some error occured. Please reach out to your System Admin';
                system.debug( e.getMessage() );

            } 
        }

        return lWrap;

    }




   




    @AuraEnabled
    public static sObject getRecentlyCreatedRecord(String recordId, List<String> fields, String objectName){
        sObject createdRecord;
        try {
            String query = 'SELECT Id, '+String.join(fields,',')+' FROM '+objectName+' WHERE Id = \''+recordId+'\'';
            List<SObject> sobjList = Database.query( query );
            createdRecord = sobjList.get(0);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return createdRecord;
    }


    @AuraEnabled(cacheable=true)
    public static List<Sobject> getAllRecord(String objectType, List<string>fieldList){

        string query = 'Select ';
      
        

        for(Integer i=0;i<fieldList.size()-1;i++ ){
            query = query+fieldList[i]+' ,';

        }

        

        
        query = query+fieldList[fieldList.size()-1]+' From '+objectType +' Where Name!= null And Type != null ';

		system.debug('--->'+query);
        List<Sobject> checkList = database.query(query);
        system.debug('chek '+checkList);
        
        return checkList;
       

    }





     @AuraEnabled(cacheable=true)
    public static List<Sobject> getRecord(String objectType, List<string>fieldList,String Id){

        string query = 'Select ';
      
        

        for(Integer i=0;i<fieldList.size()-1;i++ ){
            query = query+fieldList[i]+' ,';

        }

        

        
        query = query+fieldList[fieldList.size()-1]+' From '+objectType + ' Where Id='+Id+' LIMIT 1';

		system.debug('--->'+query);
        List<Sobject> checkList = database.query(query);
        system.debug('chek '+checkList);
        
        return checkList;
       

    }



    @AuraEnabled(cacheable=true)
    public static List<String> getLookUpList(String objType){ 
    Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objType).getDescribe().fields.getMap();
    List<String> lookUpList = new List<String>();
        
    for(String s : objectFields.keySet())
    {
    Schema.DescribeFieldResult lfieldLabel = objectFields.get(s).getDescribe();
    Schema.DisplayType dType = lfieldLabel.getType();
    string fieldType = String.ValueOf(dType);
        if(fieldType == 'Reference'){
            
        system.debug('******'+lfieldLabel.getName());
            lookUpList.add(lfieldLabel.getName());
        
    }

}      
        return lookUpList;
        
}
        

        
 
    
    @AuraEnabled(cacheable=true)
    public static  List<String> returnApi(String fieldName){
        List<String> fieldList = new List<String>();
       
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(fieldName);
		Map<String, Schema.SObjectField> fieldMap = targetType.getDescribe().fields.getMap();
    	for (Schema.SObjectField field : fieldMap.values()) {
         
        		System.debug(field.getDescribe().getName());
            	fieldList.add(field.getDescribe().getName());
            
     }
        return fieldList;
     
    }
    
    
    
    @AuraEnabled//(cacheable=true)
    public static List<String> getAllObjectNameList(){
        
      List<string> SObjectList = new List<string>();

for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
   String name = objTyp.getDescribe().getName();
   // Exclude all the unwanted Sobjects e.g. History, Share etc..

   
      SobjectList.add(name);
      System.debug( 'Name : ' + name);
   

}
        
        return SObjectList;
       

	        
    }
    
    
    public class UserWrapper{
        
        @AuraEnabled
        public List<String> userNameList  {get;set;}
        
          @AuraEnabled
        public List<user> userList  {get;set;}


    }


    @AuraEnabled(cacheable=true)
    public static List<Profile> getProfileFromId(String ProfileId){
       system.debug('---->'+ProfileId);
        system.debug('------------'+[Select Id,Description,Name From Profile Where Id=:ProfileId]);
        return [Select Id,Description,Name From Profile Where Id=:ProfileId];

    }


    @AuraEnabled(cacheable=true)
    public static List<PermissionSet> getPermission(String userLicenceId){


        return [Select Id,ProfileId,Name From PermissionSet];



    }
    
    @AuraEnabled(cacheable=true)
    public static UserWrapper getUserList(){
        
		UserWrapper  uWrap = new UserWrapper();
        uWrap.userList = new List<user>();
        uWrap.userNameList = new List<String>();
        
        
        uWrap.userList  = [Select Id,Name,ProfileId,UserRoleId From User];
       
        
        for(user u:uWrap.userList ){
            
            uWrap.userNameList.add(u.Name);
        }
		system.debug('uWrap.userNameList'+uWrap.userNameList);        
        return uWrap;
    }
    
    
    
    
    @AuraEnabled
    public static void addTodo1(String uName,String pass,string newTodo){
        
         List<UserDatabase__c> userDatabaseList = new List<UserDatabase__c>();
        
        
        userDatabaseList = [Select Password__c,UserName__c,TodoList__c From UserDatabase__c Where Password__c =:pass And UserName__c=:uName Limit 1];
        system.debug('here is userDatabase'+userDatabaseList);
        for(UserDatabase__c u:userDatabaseList){
            
             u.TodoList__c = u.TodoList__c + newTodo ;
        }
         system.debug('here is userDatabase after update'+userDatabaseList);
        
        update userDatabaseList;
        
        
        
    }
    
    @AuraEnabled
    public static String varifyUserName(String uName,String pass){
        
        List<UserDatabase__c> userDatabaseList = new List<UserDatabase__c>();
        String todoList ;
        
        userDatabaseList = [Select Password__c,UserName__c,TodoList__c From UserDatabase__c Where Password__c =:pass And UserName__c=:uName Limit 1];
        
        for(UserDatabase__c u:userDatabaseList){
            
            todoList = u.TodoList__c ;
        }
        system.debug('here is list->'+userDatabaseList);
        system.debug('here is todoList-->'+todoList);
        
        return todoList;
        
        
        
    }
    
    
    
    @AuraEnabled
    public static void createUserDatabase(string name,string uName,string pass){
        
        List<UserDatabase__c> userDatabaseList = new List<UserDatabase__c>();
        
        UserDatabase__c userDb = new UserDatabase__c(Name=name,Password__c=pass,UserName__c=uName);
        
        userDatabaseList.add(userDb);
        system.debug('user db object '+userDatabaseList);
        
        Insert userDatabaseList;
        
    }
    
    @AuraEnabled
    public static void createContact(List<Contact> conList){
        
        if(!conList.isEmpty()){
            
            Insert conList;
        }
    }
    
    
    
     @AuraEnabled
    public static void createConWithLookUpAc(String lName,Id acId){

        List<Contact> conList = new List<Contact>();
        
        Contact con =  new Contact();
        con.AccountId = acId;
        con.LastName = lName;

        conList.add(con);


        if(!conList.isEmpty()){
          Insert conList;

        }

      
    }
    
    
     // @AuraEnabled
     // public static List<Account> getAccountList(){

      //  List<Account> acList = [Select Name,Phone,Type From Account Where Name!=null Limit 50000];

      //  return acList;

      //}

      @AuraEnabled(cacheable=true)
      public static List<Account> getAccountName(String s){
        String temp = '%'+s+'%';
        
        List<Account> accList = [Select Name,Type,Id From Account Where Type Like :temp];
        system.debug('accoint list'+temp+'---------'+accList);
        return accList;
      }
    
    
    
    
    
     public class WrapperUserNamePassword{
          @AuraEnabled
        public String uName  {get;set;}
          @AuraEnabled
        public String pass  {get;set;}
    }
    
    
    
    
     @AuraEnabled
    public static WrapperUserNamePassword getUserNameAndPassword(Id conId){
        
        WrapperUserNamePassword obj = new WrapperUserNamePassword();
        
       List<Contact> conData= [Select UserName__c,Password__c From Contact Where Id=:conId Limit 1];
       
        for(Contact con:conData){
            
            obj.uName = con.UserName__c;
            obj.pass = con.Password__c;
          
        }
        
        return obj;
       
        
    }
    
    
    
    @AuraEnabled
    public static void deleteAccount(Id acId){
        
        List<Account> ac = [Select Name,Id From Account Where Id=:acId Limit 1];
        
        system.debug('Account -->'+ac);
        Delete ac;
    }
    
    @AuraEnabled
    public static List<String> getObjFieldName(String objName){
            List<String> fieldList = new List<String>();
            String SobjectApiName = objName;
        
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
          
           for(String fieldName : fieldMap.keyset()){
             fieldList.add(fieldName); 
            }
			system.debug('list is-->'+fieldList);            
            return fieldList;
    }
    
    
    @AuraEnabled
    public static List<String> getAllObjName(){
        
        List<String> objNameList = new List<String>();
        
        Integer count = 0;
        
        for(Schema.SObjectType o: Schema.getGlobalDescribe().values()){
            if(count>300){
                break;
            }
    		objNameList.add(o.getDescribe().getName());
            system.debug('list -->'+o.getDescribe().getName());
            
            count++;
            
			}
        //system.debug('obj list-->'+objNameList);
        
        return objNameList;

        
        
    }

}
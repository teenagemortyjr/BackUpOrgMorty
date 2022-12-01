public with sharing class PickListWrapper {


 

    public class setPickListWrapper
    {

      
    @AuraEnabled
    public List<String> statusList {get; set;}

    @AuraEnabled
    public List<String> priorityList {get;set;}

    }

    
    
    
    
    
    @AuraEnabled(cacheable=true)
    public  static String getCaseStatus(String recordId){

            Case caseList = [Select Id,Status From Case Where Id =:recordId Limit 1];

            return caseList.Status;

    }
   




    @AuraEnabled(cacheable=true) 
    public static setPickListWrapper  getPickList(){ 

        setPickListWrapper pickListObj = new setPickListWrapper(); 
        pickListObj.priorityList =  new List<String>();
        pickListObj.statusList  = new List<String>();

        Schema.DescribeFieldResult fieldResult = case.Status.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            if(pickListVal.getLabel() !='Invoiced' && pickListVal.getLabel() !='Closed Won' && pickListVal.getLabel() !='Closed Lost' ){
                system.debug('here is value-->'+pickListVal.getLabel());
                pickListObj.statusList.add(pickListVal.getLabel());

            } 
        }
  

        Schema.DescribeFieldResult fieldResult2 = case.Priority.getDescribe();
        List<Schema.PicklistEntry> ple2 = fieldResult2.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple2){
            if(pickListVal.getLabel() !='Invoiced' && pickListVal.getLabel() !='Closed Won' && pickListVal.getLabel() !='Closed Lost' ){
                                system.debug('here is value-->'+pickListVal.getLabel());
                pickListObj.priorityList.add(pickListVal.getLabel());

            }

    }
System.debug(pickListObj.priorityList);
System.debug(pickListObj.statusList);

    return pickListObj;

}




    

}
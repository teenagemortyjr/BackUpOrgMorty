public class TrailHeadDataBatch implements Database.batchable<sObject>{ 
    
   
   public List<Trailhead_Data__c> start(Database.BatchableContext info){ 
       		List<Trailhead_Data__c> trailHeadList = new List<Trailhead_Data__c>();
       		
       for(Integer i=0;i<1000;i++){
           
           Trailhead_Data__c t = new Trailhead_Data__c(URL__c='www.YouTube.com',Name='t'+i,Name__c = 't');
           trailHeadList.add(t);
           
           
         }
       
       		
      	return trailHeadList;
       
       
   }     
   public void execute(Database.BatchableContext info, List<Trailhead_Data__c> trailHeadList){
       
       system.debug('here is the list-->'+trailHeadList);
       
       insert trailHeadList;
   }     
   public void finish(Database.BatchableContext info){  
       
       List<String> strList = new List<String>();
       strList.add('chaudhary.prashant@cloudanalogy.com');
       EmailTest.sendSimpleEmail(strList,'test record has been inserted','TrailHead record has been inserted');
               
       
   } 
}
global class TrailHeadDataScheduler implements Schedulable{
    
    
    global void execute(SchedulableContext SC) {
        
        
        database.executeBatch(new TrailHeadDataBatch());
        
      
   }
    
    
    
    

}
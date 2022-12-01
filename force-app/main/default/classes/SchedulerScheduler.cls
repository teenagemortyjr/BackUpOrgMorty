global class SchedulerScheduler implements Schedulable{
    global void execute(SchedulableContext SC) {
        
        final Integer BatchSize = 100;
       
        DefaultBatch db = new DefaultBatch();
       Database.executeBatch(db, BatchSize);
    } 
}
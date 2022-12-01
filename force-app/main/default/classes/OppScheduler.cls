public class OppScheduler  implements schedulable {
    
    public void execute(schedulablecontext ctx) {
        
 		database.executeBatch(new oppBatch());
        
    }

}
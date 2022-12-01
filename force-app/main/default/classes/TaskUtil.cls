public class TaskUtil {
    
    public static String test(String a){
        
    
     String returnName ;

		if(String.isBlank(a)){
   		 system.debug('String is empty');
            returnName = 'String is empty';
    
			}else{
   		 System.debug('string is not empty');
             returnName = 'string is not empty';
				}
		return returnName;
        
    }

    public static String getTaskPriority(String leadState) {
        // Validate input
        if (String.isBlank(leadState)) {
            return null;
        }
        String taskPriority;
        if (leadState == 'CA') {
             taskPriority = 'High'; 
        } else {
             taskPriority = 'Normal';
        }
        return taskPriority;
    }
}
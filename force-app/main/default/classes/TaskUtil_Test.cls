@isTest
public class TaskUtil_Test {
    
   
        

    @isTest static void testTaskPriority() {
        
       		String[] val1 = new String[]{'Normal','High','Low','', 'kahfiahsifh','sajfoisafoiahsoif'};
            String[] val2 = new String[]{'NY','nY','Ca','','','yuilk'};
                
        
       		 String pri = TaskUtil.getTaskPriority('Ca');
                
       		 System.assertEquals('High', pri);
        
        
        
            pri = TaskUtil.getTaskPriority('');
                
       		 System.assertEquals(null, pri);
        
        
             pri = TaskUtil.getTaskPriority('Who');
                
       		 System.assertEquals('Normal', pri);
        
        
         pri = TaskUtil.test('');
                
       		 System.assertEquals('String is empty', pri);
        
        
         pri = TaskUtil.test('sfsdf');
                
       		 System.assertEquals('String is not empty', pri);
        
        

           
           
        
        
    
		}
	}
public class callScheduler {
    
    public static void calloppscheduler(){
 	OppScheduler scheduleop = new oppScheduler();
 	string s1 = '0 02 * * * ?';
 	system.schedule('BatchOpp_ever_1_minute',s1,scheduleop);
     system.debug('scheduler has started..');
        
 	}

    

}
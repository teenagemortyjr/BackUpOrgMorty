public class executeBatch {
 public static Id Jobid;

 public static void schedulerMethod(){
 TrailHeadDataScheduler schedulerObj=new TrailHeadDataScheduler();
 String sch='0 0 12 * * ?';
 jobid=System.schedule('jobName', sch, schedulerObj);
 }

}
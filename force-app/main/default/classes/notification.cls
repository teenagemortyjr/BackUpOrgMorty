public class notification {
    
    public static void sendNotification(){
        Messaging.CustomNotification customNotification = new Messaging.CustomNotification();
        customNotification.setTitle('Sucess');
        customNotification.setBody('Account Has Been Inserted');
        customNotification.setTargetId('0015i00000PT38jAAD');
        customNotification.setNotificationTypeId('0ML5i000000g04KGAQ');
        
        try{
            customNotification.send(getUserIds());
        }catch(Exception e){
            system.debug('error'+e);   
        }    
    }
    
     public static set<String> getUserIds() {
        set<String> userids = new set<String>();
         for(user u: [select id, Name from user Where Name = 'prashant chaudhary']){
             userids.add(u.id);
         }
       
        return userids;
    }
    
    public static List<CustomNotificationType> getNotificationList() {
        List<CustomNotificationType> notificationTypeList = new  List<CustomNotificationType>();
        notificationTypeList = [SELECT Id, CustomNotifTypeName, DeveloperName FROM CustomNotificationType ];
        return notificationTypeList;
    }
    
    public static void createAccount(){
        Account ac = new Account(Name ='Dell');
        insert ac;
        sendNotification();
    }

}
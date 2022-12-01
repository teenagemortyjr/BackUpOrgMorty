public class CameraClass {
    
    
    public static void showRecord(List<Camera__c> cameraList){
        
        //List<Camera__c> cameraList = new List<Camera__c>();
        //cameraList = [Select Id,Name,Megapixel__c,Type__c  From Camera__c  Where ( Name ='Canan' and Type__c = 'Compact Cameras' and Megapixel__c = 3.0) Limit 1];
        system.debug('here is CameraList ---> '+cameraList);       
        
       // system.debug('Here is List-->'+[Select Id,Name,Megapixel__c,Type__c  From Camera__c  order by CreatedDate Desc Limit 1]);
    }
    
    
    public static void makeNewRecordRandom(){
        
        
        List<Camera__c> cameraList =new List<Camera__c>();
		List<String> cameraName =new List<String> {'Nikon','Canan','Mi','Samgung','Altec'};
		List<String> cameraType = new List<String>{'Compact Cameras','DSLR Cameras','Mirrorless Cameras','Action (Adventure) Cameras','360 Cameras','Medium Format Cameras','Traditional Film Cameras'};

		for(Integer i = 6;i<100;i++){
    
        Integer randomNumber = Integer.valueof((Math.random() * 4));
        Integer mp = Integer.valueof((Math.random() * 100));
        Integer ty = Integer.valueOf(Math.random()*7); 
        Camera__c c = new Camera__c(Name = cameraName[randomNumber],Megapixel__c = mp,Type__c = cameraType[ty]);
        
   		 cameraList.add(c);
    	}

		insert cameraList;
    }

}
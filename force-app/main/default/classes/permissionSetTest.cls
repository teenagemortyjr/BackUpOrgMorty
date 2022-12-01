public class permissionSetTest {
    
    public static void  removePermissionSet(){
        
       		 List<User> usersLicense = [Select Id, Name, Profile.UserLicense.Name from User 
   			 Where Profile.UserLicense.Name != 'Salesforce'];
        	system.debug('userLicense'+usersLicense);
        
    }

}
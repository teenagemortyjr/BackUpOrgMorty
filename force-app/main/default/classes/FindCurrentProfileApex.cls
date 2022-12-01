public class FindCurrentProfileApex {
    
    
    @AuraEnabled(cacheable=true)
    public static string getCurrentProfile(){
        
        Profile p = [Select Name from Profile where Id =: userinfo.getProfileid()];
		String pname = p.name;
        system.debug('current profile-->'+pname);
        
        return pname;
    }

}
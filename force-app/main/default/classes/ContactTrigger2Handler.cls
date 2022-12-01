public class ContactTrigger2Handler {
    
    public static void updateEmail(List<Contact> newConList){
        
        List<Contact> conList = [Select Id,Email From Contact ];
        
        Map<String,boolean> emailCon = new Map<String,boolean>();
        
        for(Contact con: conList){
            if(con.Email != null && !emailCon.containsKey(con.Email)){
            emailCon.put(con.Email,true);
            }
                
        }
        
        
        
        for(Contact con: newConList){
            
            if(emailCon.containsKey(con.Email)){
                con.AddError('Con not update this contact because email alreay exist');
                
            }
            
            
        }
        
        
        
        
    }

    
    public static void checkEmailExist(List<Contact>newConList){
        
        List<Contact> conList = [Select Id,Email From Contact ];
        
        Map<String,boolean> emailCon = new Map<String,boolean>();
        
        for(Contact con: conList){
            if(con.Email != null && !emailCon.containsKey(con.Email)){
            emailCon.put(con.Email,true);
            }
                
        }
        
        
        
        for(Contact con: newConList){
            
            if(emailCon.containsKey(con.Email)){
                con.AddError('Con not create this contact because email alreay exist');
                
            }
            
            
        }
        
        
        
        
    }
}
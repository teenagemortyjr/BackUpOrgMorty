public class TaskByAmerSir {
    
    
    
    public static boolean checkPermissoionSetExist(String userName, String permissionSetLableList){
        
        
        List<PermissionSetAssignment> pSet = [SELECT Id, PermissionSetId, PermissionSet.Name, PermissionSet.Label,  AssigneeId, Assignee.Name FROM PermissionSetAssignment WHERE Assignee.Name =:userName];
        
        for(PermissionSetAssignment p: pSet){
            
            if(p.PermissionSet.Label == permissionSetLableList){
                return true;
            }
            
        }
        
        return false;
        
        
    }
    
    
    public static void setPermissionForUser(){
        
        List<String> roleNameList = new List<String> {'CEO','COO','Marketing Team','second_CEO','SVP, Human Resources','VP, North American Sales'};
        List<String> profileName = new List<String> {'Standard Platform User'};
        List<String> PermissionSetList = new List<String> {'CRM User','Order Management Agent','Order Management Shopper'};       
        List<Profile> profileList = [Select Id,Name From Profile Where Name In:profileName ];
        List<UserRole> userId = [Select Id,Name From UserRole Where Name IN: roleNameList ];
        List<Id> userRoleIdList = new List<Id>();
        List<Id> profileIdList = new List<Id>();
        list<Id> PermissiontListId  = new List<Id>();
        Id ProfileId = Null;
        
        for(UserRole ur:userId ){
            userRoleIdList.add(ur.Id);
        }
        
        for(Profile p: profileList){
            profileIdList.add(p.Id);
            ProfileId = p.Id;
        }
        
        system.debug('user--Id'+userRoleIdList+' '+profileIdList);        
        
        List<user> userList = [Select Id,Name,UserRoleId,ProfileId From user Where (UserRoleId IN:userRoleIdList) And (ProfileId IN:profileIdList)];
        system.debug('All Selected User List-->'+userList);
        
        List<PermissionSet> PermissiontList = [Select Id,Label, ProfileId From PermissionSet Where (Label IN: PermissionSetList)];
        
        for(PermissionSet p:PermissiontList ){
            PermissiontListId.add(p.Id);
        }
        
        
        List<PermissionSetAssignment> permissionSetListNew = new List<PermissionSetAssignment>();
        
        
        for (User u :userList ){ 
            for(PermissionSet p: PermissiontList){
                if(!checkPermissoionSetExist(u.Name,p.Label)){
                    PermissionSetAssignment psa = new PermissionSetAssignment (PermissionSetId = p.Id, AssigneeId = u.Id);
                    permissionSetListNew.add(psa);}
                else{
                    system.debug('permission already existed');
                }
                system.debug('PermissionSetAssignment'+permissionSetListNew);
            }
        }
        try{
            upsert permissionSetListNew;
            system.debug('permissionSetListNew'+permissionSetListNew);
        }catch(exception e){
            system.debug('exception caught' + e);
        }
        
    }
    
}
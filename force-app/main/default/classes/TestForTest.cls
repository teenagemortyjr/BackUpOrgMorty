public class TestForTest {
    
    public static void start(){
        
        List<PermissionSetAssignment> pSet = [SELECT Id, PermissionSetId, PermissionSet.Name, PermissionSet.Label,  AssigneeId, Assignee.Name FROM PermissionSetAssignment WHERE Assignee.Name = 'Takila jow' And PermissionSetId= '0PS5i000000tARXGA2'];
    	
        system.debug('All permission set --->'+pSet);
        
        delete pSet;
        /*
        Map<String,List<String>> userNameVsPermissionSetList_map = new Map<String,List<String>>();
        
        for(PermissionSetAssignment p: pset){
            if(userNameVsPermissionSetList_map.containsKey(p.Assignee.Name)){
                
                List<String> newStrList = userNameVsPermissionSetList_map.get(p.Assignee.Name);
            	newStrList.add(p.permissionSet.Label);
                
                userNameVsPermissionSetList_map.put(p.Assignee.Name , newStrList);
            }
            else{
                userNameVsPermissionSetList_map.put(p.Assignee.Name , new List<String>{p.permissionSet.Label});
                
            }
            
        }*
        
        system.debug('map-->'+userNameVsPermissionSetList_map);
                      }*/
        
    }
}
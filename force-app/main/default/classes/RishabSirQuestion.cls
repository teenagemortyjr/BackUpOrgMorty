public class RishabSirQuestion {
    
    public static void q1(){
        
        Map<Integer,Integer> indexVsPhone = new Map<Integer,Integer>();
        final Integer MAXSIZE = 3;
        List<Contact> conList = new List<Contact>();
        
        
        for(Integer i=0;i<3;i++){
            Integer value = 110+i;
            indexVsPhone.put(i, value);
        }
        
        
        for(Integer i =0;i<10;i++){
            Contact con = new Contact();
            con.LastName = 'Rishav '+i+' -> '+indexVsPhone.get(math.mod(i,MAXSIZE));
            conList.add(con);
        }
        
        system.debug('conList-->'+conList);
        
        for(Contact con: conList){
            system.debug('Name ->'+con.LastName);
        }
        
        
        
    }

}
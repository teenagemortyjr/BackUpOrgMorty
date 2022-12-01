public class WeatherApiWrapper {
    
    
    @AuraEnabled
    public location location;
   
       
    @AuraEnabled
    public current current;


    
    
   
    public class location{
        @AuraEnabled
        public string name;
        
        @AuraEnabled
        public string country;
              
    }
    
    
    

    public class current{
         
        @AuraEnabled
        public string temp_c;
        
        @AuraEnabled
        public string temp_f;
        
        @AuraEnabled
        public condition condition;
         
        
        
    }
    
    
    public class condition{
        @AuraEnabled
        public String text;

        @AuraEnabled
        public String icon;
    }
    

}
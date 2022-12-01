public class WeatherApiLwc {
    
    
	@AuraEnabled(cacheable=true)
    public static WeatherApiWrapper callWeatherApi(){
        
        String API_URL = 'http://api.weatherapi.com/v1/forecast.json?key=5a6a1bb6581448a29ae91822221107&q=Dehradun&days=3&aqi=yes&alerts=yes';
        
        
          HttpRequest req = new HttpRequest();  
          req.setEndpoint(API_URL);
          req.setMethod('POST');
     
      
         Http http = new Http();
         HTTPResponse res = http.send(req);
         System.debug(res.getBody());
        
         WeatherApiWrapper parseData =  new  WeatherApiWrapper();
        parseData = (WeatherApiWrapper)JSON.deserialize(res.getBody(),WeatherApiWrapper.class );
        
      system.debug('here is the wrapper class-->'+parseData.location.country);
     
      return parseData;
         
            
    }

}
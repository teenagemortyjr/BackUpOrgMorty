public class Covid19Controller {
    
    @AuraEnabled
    public static Covid19Parser getCovidData(){
        
        final String  baseUrl = 'https://api.covid19api.com/summary';
        HttpRequest req = new HttpRequest();
		req.setEndPoint(baseUrl);
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json');
        
        HTTP h = new HTTP();
        HttpResponse response =  h.send(req);
        
        Covid19Parser parse =  Covid19Parser.parse(response.getBody().replace('"Global":','"AllStates":'));
        
        return parse;
        
        
        
        
    }

}
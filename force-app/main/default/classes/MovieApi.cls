public with sharing class MovieApi {
    @AuraEnabled
    public static String sendData(String movieName){
        Http http = new Http();
    
        HttpRequest req  = new HttpRequest();
        
       
        req.setEndpoint('http://www.omdbapi.com/?t='+movieName+'&apikey=f249b4f4');
        req.setMethod('GET');
    
        HttpResponse response = new HttpResponse();
        response = http.send(req);
    
        if(response.getStatusCode() == 200){
            System.debug('response-->'+ response.getBody());
        }else{
            System.debug('error occur');
        }
        return response.getBody();
    }
   
}
public with sharing class WeatherApi {

    public static void getLocation(){

        Access_Token_For_Weather__mdt getAccessTkoken  = [Select AccessToken__c from Access_Token_For_Weather__mdt  limit 1 ];

        System.debug('This is the data-->'+ getAccessTkoken.AccessToken__c);

        String apiKey = getAccessTkoken.AccessToken__c;
         
        String  apiKey2  = getAccessTkoken.AccessToken__c; 
            
        String location = 'Palampur';
	
        String apiUrl = '';
        

        Http http = new Http();
    
        HttpRequest req  = new HttpRequest();
        req.setEndpoint('http://api.weatherapi.com/v1/current.json?key=78503df2a9a643599f554901241009&q=Palampur&aqi=no');
      // req.setEndpoint('http://www.omdbapi.com/?t=joker&apikey=f249b4f4');
        req.setMethod('GET');

        HttpResponse response = new HttpResponse();
        response = http.send(req);

        if(response.getStatusCode() == 200){
            System.debug('response-->'+ response.getBody());
        }else{
            System.debug('error occur');
        }
    
    }
   
}
public class SendSMS {
     
    @AuraEnabled(cacheable=true)
    public static void sendMessage(String toNumber, String message) {

         Access_Token_For_Weather__mdt getAccessTkoken  = [Select AccessToken__c,End_Point__c from Access_Token_For_Weather__mdt where QualifiedApiName = 'twilio_tokens' limit 1 ];

        String accountSid = getAccessTkoken.AccessToken__c; 

        String authToken = getAccessTkoken.End_Point__c;

        String fromNumber = '+19384448220'; 



        String url = 'https://api.twilio.com/2010-04-01/Accounts/' + accountSid + '/Messages.json'; 

        

        HttpRequest req = new HttpRequest();

        req.setMethod('POST');

        req.setEndpoint(url);

        req.setHeader('Authorization', 'Basic ' + accountSid + ':' + authToken);

        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        req.setBody('To=' + toNumber + '&From=' + fromNumber + '&Body=' + message);



        Http h = new Http();

        HttpResponse response = h.send(req);

        if(response.getStatusCode() == 201){
            System.debug('Send Message Successfully');
           
        }else{
            System.debug('Error Occurs');
        }



       

    }

}
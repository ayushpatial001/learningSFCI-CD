public class OutboundInt {
    public static String getAccessToken() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://tmc-ca-dev-ed.develop.my.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        //req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug(res.getBody());
        Map<String,Object> reqData = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
        String accessToken = (String) reqData.get('access_token');
        System.debug(accessToken);
        Return accessToken;
    }
    public static void createAccountAPI(){
        HttpRequest req = new HttpRequest();
        String bearerToken = OutboundInt.getAccessToken();
        req.setHeader('Authorization','Bearer ' + bearerToken);
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint('https://tmc-ca-dev-ed.develop.my.salesforce.com/services/apexrest/accounts?name=Rajat');
        //req.setBody('');
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug(res.getBody());
    }
}
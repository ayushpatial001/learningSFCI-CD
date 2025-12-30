public with sharing class makePayments {
     @AuraEnabled
    public static String makePayment(Integer totalAmount){
         String totalAmount1 = String.valueOf(totalAmount);
        System.debug('totalAmount1'+totalAmount1);
        System.debug('this is total Amount'+ EncodingUtil.urlEncode(totalAmount1,'UTF-8') );
        Http http =  new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setEndpoint('https://api.stripe.com/v1/charges');
        req.setMethod('POST');
        req.setBody('amount='+EncodingUtil.urlEncode(totalAmount1,'UTF-8')+'&currency='+EncodingUtil.urlEncode('USD','UTF-8')+'&source='+EncodingUtil.urlEncode('tok_visa','UTF-8'));
        
        HttpResponse response = new HttpResponse();
        response = http.send(req);

        if(response.getStatusCode() == 200){
           return  response.getBody();
        }
        return 'Error';
        
    }
}
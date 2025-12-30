public with sharing class ProductImageClass {
    @AuraEnabled(cacheable=true)
    public static List<ProductWrapper> getProductsWithPricesAndImages() {
        List<ProductWrapper> productList = new List<ProductWrapper>();

        // Fetch all products with their standard price
        //Date dateCreate = Date.Today().addDays(-1);
        List<Product2> products = [
            SELECT Id, Name,Price__c,
                 (SELECT UnitPrice FROM PricebookEntries WHERE Pricebook2.IsStandard = true LIMIT 1)
            FROM Product2 WHERE Price__c != Null  
        ];

        System.debug('products'+products);

        // Prepare a map to store the product IDs for the next query
        Set<Id> productIds = new Set<Id>();
        for (Product2 product : products) {
            productIds.add(product.Id);
        }

         System.debug('productIds'+productIds);
        

        // Fetch the ContentDocumentLinks for all the products
        List<ContentDocumentLink> productImageLinks = [
            SELECT ContentDocumentId, LinkedEntityId 
            FROM ContentDocumentLink 
            WHERE LinkedEntityId IN :productIds
        ];

         System.debug('productImageLinks'+productImageLinks);

        // Prepare a map to link Product Ids to ContentDocumentIds
        Map<Id, Id> productToImageMap = new Map<Id, Id>();
        for (ContentDocumentLink link : productImageLinks) {
            productToImageMap.put(link.LinkedEntityId, link.ContentDocumentId);
        }

          System.debug('productToImageMap'+productToImageMap);

        // Fetch images (ContentVersion) using the ContentDocumentIds
        List<ContentVersion> allImages = [
            SELECT Id, ContentDocumentId, ContentUrl 
            FROM ContentVersion 
            WHERE ContentDocumentId IN :productToImageMap.values()
            ORDER BY CreatedDate ASC
        ];

       System.debug('allImages'+allImages);

        // Prepare a map to store the image URLs linked to each ContentDocumentId
        Map<Id, String> contentDocIdToUrlMap = new Map<Id, String>();
        for (ContentVersion img : allImages) {
            contentDocIdToUrlMap.put(img.ContentDocumentId, '/sfc/servlet.shepherd/version/download/' + img.Id);
        }

         System.debug('contentDocIdToUrlMap'+contentDocIdToUrlMap);
         
        // Create ProductWrapper instances and set the properties
        for (Product2 product : products) {
            Decimal price = product.PricebookEntries.isEmpty() ? 0 : product.PricebookEntries[0].UnitPrice;

            // Fetch the image URL for the product from the contentDocIdToUrlMap
            Id contentDocId = productToImageMap.get(product.Id);
            String imageUrl = contentDocId != null && contentDocIdToUrlMap.containsKey(contentDocId) 
                ? contentDocIdToUrlMap.get(contentDocId) 
                : '';

            productList.add(new ProductWrapper(product.Id,90, imageUrl,product.Name));
        }
        System.debug('productList'+productList);
        return productList;
    }

    public class ProductWrapper {
        
        @AuraEnabled public String productId;
        @AuraEnabled public Decimal price;
        @AuraEnabled public String imageUrl;
        @AuraEnabled public String name;
      
       
        

        public ProductWrapper(String productId,Decimal price, String imageUrl, String name) {
           
            this.productId = productId;
            this.price = price;
            this.imageUrl = imageUrl;
            this.name = name;
           
            
        }


    }


    
    @AuraEnabled(cacheable=true)
    public static  List<Product2> methodName(String allData){
        return [SELECT IsActive, Name, Id,  Description FROM Product2 where Id =: allData];
    }
 

    

    


    @AuraEnabled
    public static String makePayments(Integer totalAmount){
      
       
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
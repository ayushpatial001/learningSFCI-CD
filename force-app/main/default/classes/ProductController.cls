public with sharing class ProductController {
    @AuraEnabled(cacheable=true)
    public static List<ProductWrapper> getProductsWithPricesAndImages() {
        List<ProductWrapper> productList = new List<ProductWrapper>();

        // Fetch all products with their standard price
        //Date dateCreate = Date.Today().addDays(-1);
        List<Product2> products = [
            SELECT Id, Name, Price__c,
                 (SELECT UnitPrice FROM PricebookEntries WHERE Pricebook2.IsStandard = true LIMIT 1)
            FROM Product2 WHERE Price__c != null
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

            productList.add(new ProductWrapper(product.Price__c, imageUrl,product.Name));
        }
System.debug('productList'+productList);
        return productList;
    }

    public class ProductWrapper {
        
        @AuraEnabled public Decimal price;
        @AuraEnabled public String imageUrl;
        @AuraEnabled public String name;
       
        

        public ProductWrapper(Decimal price, String imageUrl, String name) {
           
           
            this.price = price;
            this.imageUrl = imageUrl;
            this.name = name;
            
        }
    }
}
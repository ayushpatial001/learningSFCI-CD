public with sharing class GetAllFoodItems {


   @AuraEnabled
   public static List<Food_Item__c> getFoodItems(){

     return [SELECT Name, Id, Price__c, Item_Image__c, Description__c, Category__c, Sub_Category__c FROM Food_Item__c];

   }

   @AuraEnabled
   public static List<Food_Item__c> getFoodItem(String category , String subCat){
    return [SELECT Name, Id, Price__c, Item_Image__c, Description__c, Category__c, Sub_Category__c FROM Food_Item__c WHERE Category__c =: category AND Sub_Category__c =: subCat];

   }


   @AuraEnabled
   public static void storeFood(string name, Integer quantity, Integer totalPrice){
      Food_Order__c getdata = new Food_Order__c(Product_Name__c = name,Quantity__c = quantity,TotalPrice__c = totalPrice);
      try{
        insert getdata;
      }catch(DMLException e){
          System.debug('asfdf');
      }
      
     
   }
   
}
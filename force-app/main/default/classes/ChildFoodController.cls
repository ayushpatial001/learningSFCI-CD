public with sharing class ChildFoodController {


    @AuraEnabled
    public static void methodName(List<SObject> cartList){

        try {
           System.debug(cartList);
           
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String methodName1(String nameOfItem, Integer totalQunatity, Integer totalaPrice){
        String returnMessage = '';
        try {
            Food_Order__c makeData = new Food_Order__c();
            makeData.Product_Name__c = nameOfItem.removeEnd(', ');
            makeData.Quantity__c  = totalQunatity;
            makeData.TotalPrice__c = totalaPrice;
            insert makeData;
            returnMessage = 'Data send succesfully';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
           
        }
        return returnMessage;
    }
}
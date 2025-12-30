public with sharing class PracticeQuestion27 {
     

     public static void method1(){
        /*
      Create a custom object Product__c with fields Name__c (String) and Price__c (Decimal). 
      Write an Apex class that uses a map where the key is the product name and
       the value is the price to insert multiple Product__c records.
     */

        Map<String, Decimal> mapOfCustomProduct = new Map<String, Decimal>();
     
        for(Product__c getRecord : [SELECT Price__c, Name FROM Product__c WHERE Price__c > 0 limit 10]){
                  mapOfCustomProduct.put(getRecord.Name, getRecord.Price__C);
        }
   
     }
    




     public static void method2(){
        /*
            Create a custom object Order__c with fields Account__c (Lookup to Account) and Amount__c (Decimal).
             Write an Apex class that calculates the total order amount for each account and 
             stores the results in a map where the key is the AccountId and the value is the total amount.
         */

         Map<String, Decimal> mapofTotalAmount = new  Map<String, Decimal>();
         List<AggregateResult> getagGregateResult  = [SELECT  AccountName__c, SUM(Amount__c) sum FROM Order__c GROUP BY AccountName__c];
         for(AggregateResult gtr : getagGregateResult){
             String name = (String)gtr.get('AccountName__c');
             Decimal amount =(Decimal) gtr.get('sum');
            mapofTotalAmount.put(name, amount);
         }
        System.debug(mapofTotalAmount);


     }


     public static void method3(){
        /*
        Use aggregate queries in Apex to directly query and 
        calculate statistics such as SUM, AVG, MIN, and MAX amount of opportunity 
        where stage is closed won and closed lost.
        */

     }
     
}
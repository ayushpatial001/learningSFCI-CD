public class SumOfTestClass {
    public static void  sumOfAmount(){
        
         Map<String, Decimal> mapofTotalAmount = new  Map<String, Decimal>();
         List<AggregateResult> getagGregateResult  = [SELECT  AccountName__c, SUM(Amount__c) sum FROM Order__c GROUP BY AccountName__c];
         for(AggregateResult gtr : getagGregateResult){
             String name = (String)gtr.get('AccountName__c');
             Decimal amount =(Decimal) gtr.get('sum');
            mapofTotalAmount.put(name, amount);
         }
        System.debug(mapofTotalAmount);
    }

}
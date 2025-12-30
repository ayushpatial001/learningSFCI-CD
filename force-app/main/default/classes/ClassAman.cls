public class ClassAman {
     public static void method5(){
      Map<String, Map<String, List<String>>> mapOfWorldRecord = new Map<String, Map<String, List<String>>>();

      for(world__c rec : [SELECT country__c, state__c,city__c FROM World__c]){
          mapOfWorldRecord.put(rec.country__c, new Map<String, List<String>>{rec.state__c => new List<String>{rec.city__c}});
      }
         
         System.debug(mapOfWorldRecord);
   }

}
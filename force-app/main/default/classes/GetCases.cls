public with sharing class GetCases {

    @AuraEnabled
     public static List<Case> listOfCases(){
        return [SELECT Id, Priority, CaseNumber FROM Case limit 10];
     }
     
     @AuraEnabled
     public static List<Case> listOfParticularCase(String caseId){
      return [SELECT Id, SuppliedName, Type, Status, Reason, Origin, Priority, Subject, Description, IsClosed, ClosedDate FROM Case WHERE Id =: caseId];
     }
}
public with sharing class AllEmployeeRecordForLwc {
    @AuraEnabled
    public static List<Employee__c> getAllEmployeeMethod(){
        List<Employee__c> listOfEmployeeRecord = [SELECT Id, Name, Joining_Date__c, Total_Experience__c, Date_of_Birth__c, Email_Address__c, Aadhar_Number__c, Pan_Card_Number__c FROM Employee__c];
        return listOfEmployeeRecord;
    }
}
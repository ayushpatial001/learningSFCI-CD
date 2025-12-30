public with sharing class policyAndGuidelinesData {
    
    @AuraEnabled
    public static List<wrapper2class> getData(){
        List<wrapper2class>  dataList = new List<wrapper2class>();
        for(Employee_Regarding_Policy__c rec : [SELECT Id, EmployeeName__r.Name, Accepted_Policies__c, Remaining_Policies__c FROM Employee_Regarding_Policy__c]){
            wrapper2class recordData = new wrapper2class();
            recordData.EmployeeName = rec.EmployeeName__r.Name;
            recordData.AcceptedPolicies = Integer.valueOf(rec.Accepted_Policies__c);
            recordData.RemainingPolicies = Integer.valueOf(rec.Remaining_Policies__c);
            dataList.add(recordData);
        }
        System.debug('Data List '+dataList);
        return  dataList;
    }
    
    public class wrapper2class{
        @AuraEnabled
        public String EmployeeName;
        @AuraEnabled
        public Integer AcceptedPolicies;
        @AuraEnabled
        public Integer RemainingPolicies;
    }
}
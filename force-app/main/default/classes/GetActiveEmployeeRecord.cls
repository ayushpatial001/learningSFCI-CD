public with sharing class GetActiveEmployeeRecord {
    
    @AuraEnabled(cacheable=true)
    public static List<Employee__c>  getRecord(){
        return [Select Id, Name ,Email_Address__c, Active__c From Employee__c Where Email_Address__c != null limit 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<Employee__c> getFullRecord(String employeeId){
        try{
             System.debug('In getfullrecrd'+employeeId);
            return [SELECT Id, Name, Joining_Date__c, Total_Experience__c, Date_of_Birth__c, 
                  Secondary_Contact_Number__c, Email_Address__c, Emergency_Contact_Number__c, 
                  Salesforce_Experience__c, Salesforce_Experience_In_years__c, Aadhar_Number__c, 
                 Pan_Card_Number__c, Bank_Account_Number__c, Bank_Name__c, IFSC_Code__c, 
            Bank_Branch_Name__c, Name_of_the_Certification__c, Certification__c,
               Primary_Number__c, Active__c, Manager__c, Manager_Email__c,
             Employee_Code__c, Father_s_Name__c, Mother_s_Name__c, Gender__c FROM Employee__c where Id =: employeeId];
        }catch(Exception e){
            System.debug('e.getLine'+ e.getLineNumber());
            throw new AuraHandledException('Some Exception occured' + e);

        }
        
    } 
}
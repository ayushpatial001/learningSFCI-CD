public with sharing class longAug1 {

    public Employee__c empData;

    public longAug1() {
        String userId = UserInfo.getUserEmail() ;
         empData = [ SELECT Name, Id, Joining_Date__c, Date_of_Birth__c, Total_Experience__c, Secondary_Contact_Number__c, 
         Email_Address__c, Salesforce_Experience__c, Emergency_Contact_Number__c, Salesforce_Experience_In_years__c, Aadhar_Number__c,
          Pan_Card_Number__c, Bank_Account_Number__c, Bank_Name__c, IFSC_Code__c, Bank_Branch_Name__c, Name_of_the_Certification__c,
           Certification__c, Primary_Number__c, Active__c, Manager__c, Manager_Email__c, Employee_Code__c, Father_s_Name__c, 
           Mother_s_Name__c, Gender__c FROM Employee__c WHERE Email_Address__c =: userId limit 1];
    }

    public Employee__c getEmp(){
        return empData;
        
    }
}
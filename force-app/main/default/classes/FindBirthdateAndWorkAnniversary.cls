public with sharing class FindBirthdateAndWorkAnniversary {
    
    @AuraEnabled
    public static List<Employee__c> getWorkAnniversary(){
        Integer currentMonth = System.today().month();
        Integer currentDay = System.today().day();
        List<Employee__c>  sdd = [SELECT  Id,Name,Joining_Date__c,workAnniversary__c From Employee__c Where CALENDAR_MONTH(Joining_Date__c) =: currentMonth And DAY_IN_MONTH(Joining_Date__c) =: currentDay];
        System.debug(sdd);
            
        return sdd;
       
    }

    @AuraEnabled
    public static List<Employee__c> getBirtDate(){
        Integer currentMonth = System.today().month();
        Integer currentDay = System.today().day();
        return [SELECT Id ,Name,Email_Address__c, Date_of_Birth__c  From Employee__c Where CALENDAR_MONTH(Date_of_Birth__c) =: currentMonth And DAY_IN_MONTH(Date_of_Birth__c) =: currentDay];
    }

}
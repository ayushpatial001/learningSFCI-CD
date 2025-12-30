public with sharing class AccountDetailsWithContactCasesOpp {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){

        return [Select Id, Name, Email__c , Industry From Account limit 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> contactRecords(String accountId){

        return [SELECT Id, AccountId, Name, OtherPostalCode, OtherCountry, OtherLongitude, MailingStreet, Phone, MailingAddress, HomePhone, Email, Title, Department, Level__c FROM Contact Where AccountId =: accountId];

    }

    @AuraEnabled(cacheable=true)
    public static List<Case> caseRecords(String accountId){

        return [Select Id, AccountId, Reason,Subject,Type From Case Where AccountId =: accountId];

    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunity(String accountId){

        return [Select Id From Opportunity Where AccountId =: accountId];
    }

    



           
    
   
    
}
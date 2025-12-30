public with sharing class AccountRelatedContacForLWC {

    @AuraEnabled
    public static List<Contact> getContacts(Id accountId){

        List<Contact> listOfContact = [SELECT Id, AccountId,Account.Name, LastName, FirstName, Name, Email, Age__c, Phone FROM Contact WHERE AccountId =: accountId];

        return listOfContact;

    }
}
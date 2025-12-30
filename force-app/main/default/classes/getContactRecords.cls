public with sharing class getContactRecords {
    public String currentAccountRecordId {get;set;}
    

    public List<Contact> getContact(ApexPages.StandardController controller){
        currentAccountRecordId = ApexPages.currentPage().getParameters().get('id');

        List<Contact> conList = [SELECT  Name, Phone, Email  FROM Contact WHERE AccountId =: currentAccountRecordId];
        return conList;
    }
}
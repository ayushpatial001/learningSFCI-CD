public with sharing class UsingWrapperClassForAccount {

    public class WrapperClassForAccount{
        // Account accRecord ;
        public String idAccount = '';
        public List<Contact> conRecord{get; set;}
        public List<Case> caseRecord{get; set;}
        public List<Opportunity> oppRecord{get; set;}

        public WrapperClassForAccount(String idAccount, List<Contact> conRecord, List<Case> caseRecord, List<Opportunity> oppRecord){
        this.conRecord = conRecord;
        this.caseRecord = caseRecord;
        this.oppRecord = oppRecord;

        }


}

public static List<WrapperClassForAccount> getAccountRecord(){

    String accountId = '001dM000008cORJQA2';
    // List<Account> listOfAccount = [SELECT Id,Name FROM Account WHERE Id =:accountId];
    List<Contact> listOfRelatedContact = [SELECT AccountId, Name FROM Contact WHERE AccountId =: accountId];
    List<Case> listOfRelatedCases = [SELECT AccountId,Id FROM Case WHERE AccountId =: accountId];
    List<Opportunity> listOfRelatedOpportuinty = [SELECT AccountId, Name FROM Opportunity WHERE AccountId =: accountId];
    List<WrapperClassForAccount> storeAllDataOfContactCaseOpportuinty = new List<WrapperClassForAccount>();
    storeAllDataOfContactCaseOpportuinty.add(  new WrapperClassForAccount(accountId,listOfRelatedContact,listOfRelatedCases,listOfRelatedOpportuinty) );
    
    // List<Account> listOfContactCaseOpportunityWithAccount = [SELECT Id, Name,(SELECT Id,Name From Contacts),(Select Id,Name From Cases),(Select Id, Name FROM Opportunities) FROM Account Where Id =: accountId];
    /*
    Map<Id, List<Contact>> mapOfContactRelatedToContact = new Map<Id, List<Contact>>();
    Map<Id, List<Case>> mapOfCaseReatedToAccount = new Map<Id, List<Case>>();
    Map<Id, Liat<Opportunity>> mapOfOpportunityRelatedToAccount = new Map<Id, List<Opportuinty>>();
    for(Account acc : listOfContactCaseOpportunityWithAccount){
    if(mapOfContactRelatedToContact.isEmpty()){
        mapOfContactRelatedToContact.put(accountId,acc.Contacts);
    }else{
        mapOfContactRelatedToContact.get()
    }
    }*/

/* for(Account acc : listOfAc){
    listOfContactRelatedAccount.add(acc.Contacts.Id);
    listOfCaseRelatedAccount.add(acc.CaseId);

    }*/
    return storeAllDataOfContactCaseOpportuinty;

}


}
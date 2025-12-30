@isTest
public class AccountTriggerHandlerTest {
    
    @TestSetup
    static void makeData(){
        Account accRecord =  DataFactory.createAccount('Abbhishek', True, '123456789012345678');
        insert accRecord;
        Contact con1 = DataFactory.createContact(accRecord.Id, 'This', 'hello@il.com', 'This is working');
        insert  con1;
        Opportunity oop1 = DataFactory.createOpportunityRecord(accRecord.Id, 'This is working', 'he@gma.com');
        insert oop1;
        
        
        
    }
    
     @isTest
    static void myPositiveTesting(){
        List<Account>  fetchAccount = [SELECT Name FROM Account];
        
        delete fetchAccount;
        
        List<Contact> fetchRelatedContact = [SELECT Id,AccountId,FirstName,LastName,Email,MobilePhone, Name FROM Contact Where AccountId IN :fetchAccount];
    }

}
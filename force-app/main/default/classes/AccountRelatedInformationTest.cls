@isTest
public class AccountRelatedInformationTest {
    @TestSetup
    static void makedata(){
        
        Account acctRecord = new Account();
        acctRecord.Name = 'Testing1';
        acctRecord.AccountNumber = '123456789012345678';
        acctRecord.Email__c = 'ayushkin12@gmail.com';
        insert acctRecord;
        
        Contact contRecord = new Contact();
        contRecord.AccountId = acctRecord.Id;
        contRecord.LastName = 'APatial';
        contRecord.Email = 'ayushking12@gmail.com';
        insert contRecord;
        
        Case caseRecord = new Case();
        caseRecord.AccountId = acctRecord.Id;
        caseRecord.ContactId = contRecord.Id;
        caseRecord.Status = 'New';
        caseRecord.Origin = 'Phone';
        insert caseRecord;
        
        
       // PricebookEntry selectRecord = [SELECT Id, Pricebook2Id, Product2Id FROM PricebookEntry where Pricebook2Id = '01sdM0000040otlQAA'];
        
        Opportunity oppRecord = new Opportunity();
       // oppRecord.Pricebook2Id = selectRecord.Pricebook2Id;
        oppRecord.AccountId = acctRecord.Id;
        oppRecord.Name = 'King';
        oppRecord.CloseDate = System.today().addDays(30);
        oppRecord.StageName = 'Prospecting';
        insert oppRecord;
        
    }
    
    @isTest
    public static void myUnitTest(){
        List<Account> listOfAccountRecords = [SELECT ID, Name ,(SELECT Id From Contacts), (SELECT Id FROM Cases),(SELECT Id FROM Opportunities) FROM Account  LIMIT 1]; 
        Test.startTest();
        AccountRelatedInformation.AccountRelatedInfo();
        Test.stopTest();
        System.assertEquals(1,listOfAccountRecords.size());
    }

}
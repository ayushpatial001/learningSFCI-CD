@isTest
public class OpportunityTriggerHnadlerTest {
    
    @TestSetup
    static void makeData(){
        
       Account accountOne = DataFactory.createAccount('PNB', False, '123456789012345678');
       insert accountOne;
        
        Opportunity oppRecord = DataFactory.createOpportunityRecord(accountOne.Id, 'Created one');
        insert oppRecord;
        
        
    }
    
    @isTest
    static void myPositiveTest(){
        
        List<Opportunity> createOne = [SELECT Id From Opportunity];
        System.assertEquals(1,createOne.size());
    }

}
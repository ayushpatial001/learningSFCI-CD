@isTest
public class OpportunityBatchTest {
    
    @TestSetup
    static void makeData(){
        
        List<Opportunity> listOfOpportunity = new List<Opportunity>();   
        List<Account> accountRecord = new List<Account>();
        
        for(Integer i=0 ; i <= 100 ; i++){
            Account account1 = new Account();
            account1 = DataFactory.createAccount('Account'+ i, False, '123456789012345672','No');
            accountRecord.add(account1);
        }
        
        insert accountRecord;
        
        for(Integer i=0; i<100; i++){
            Opportunity opplist = new Opportunity();
            opplist = DataFactory.createOpportunityRecord(accountRecord[i].Id, 'Oportunity'+i);
            listOfOpportunity.add(opplist);
        }
        
        insert listOfOpportunity;
    }
    
     @isTest
    public static void myFirstTest(){
        List<Opportunity> listOfOpportunity = [Select Id FROM Opportunity];
        Test.startTest();
        OpportunityBatchClass batch = new OpportunityBatchClass();
        Database.executeBatch(batch);
        Test.stopTest();
        
        System.assertEquals(100,listOfOpportunity.size());
        
    }

}
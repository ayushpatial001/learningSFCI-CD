@isTest
public class MonthlySalaryTriggerTest {
    
    @TestSetup
    static void makeData(){
        Employee__c record = DataFactory.makeEmployeeRecord('Rajat', 'rajat12@gmail.com', '7876054795');
        insert record;
       
    }
    
    @isTest
    static void myPositiveTest(){
        List<Employee__c>  checkRecord = [SELECT Id From Employee__c];
        Test.StartTest();
        String CRON_EXP = '0 0 0 15 3 ? 2042';
        //System.Schedule('Scheudle',CRON_EXP,new MonthlySalaryScheduler());
        new MonthlySalaryScheduler().execute(null);
        Test.StopTest();
        System.assertEquals(1,checkRecord.size());
    }
    
}
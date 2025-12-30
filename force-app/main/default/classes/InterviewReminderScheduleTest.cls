@isTest
public class InterviewReminderScheduleTest {
    
    @TestSetup
    public static void makeData(){
        Employee__c empRecord = DataFactory.makeEmployeeRecord('Ayush Patial', 'patialayush3@gmail.com', '7876054795');
        insert empRecord;
        Candidate__c candidateRecord = DataFactory.createCandidateRecord('Tanish', 'tanish12@gmail.com');
        insert candidateRecord;
        Interview__c makeOneInterview = DataFactory.createInterview(empRecord.Id, candidateRecord.Id, 'Scheduled');
        insert makeOneInterview;
        Account accRecord = DataFactory.createAccount('Account1', False, '123456789012345678');
        insert accRecord; 
        Contact conRecord = DataFactory.createContact(accRecord.Id, 'Last', 'patialayush3@gmail.com', 'this si the month');
        insert conRecord;
        
        
    }
    
    @isTest
    static void myPositiveTest(){
        
        List<Interview__c>  makeInterviewData = [Select Id From Interview__c];
        List<Candidate__c>  candidateEmailId = [Select Id , Candidate_Email_id__c From Candidate__c];
        
        String cron_Exp = '0 0 9 ? * *';
        
        Test.StartTest();
        System.Schedule('Job',cron_Exp, new InterviewRemianderSchedule());
        Test.StopTest();
    }
    
}
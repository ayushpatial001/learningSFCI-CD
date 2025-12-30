@isTest
public class InterviewTriggerHandlerTest {
    
    @TestSetup
    static void makeData(){
       Employee__c employeeRecord = DataFactory.makeEmployeeRecord('Rajat', 'rajat12@gmail.com', '7876054795');
        insert employeeRecord;
        
        Candidate__c candidateRecord = DataFactory.createCandidateRecord('ayush','patialayush3@gmail.com');
        insert candidateRecord;
        
        Interview__c interviewRecord = DataFactory.createInterview(employeeRecord.Id,candidateRecord.Id, 'Scheduled');
        insert interviewRecord;
    }
    
    @isTest
    static void myPositiveTest(){
        
        List<Interview__c>  makeRecord = [Select Id FROM Interview__c];
        System.assertEquals(1,makeRecord.size());
    }

}
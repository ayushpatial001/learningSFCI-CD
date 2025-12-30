@isTest
public class LeaveTriggerHandlerTest {
    
    @isTest
    static void makeData(){
        User u1 = DataFactory.createUser('Standard User', 'ali21', 'patialayush3@gmail.com', 'Ayush', 'ayush32123@gmail.com');
        System.runAs(u1){
            Employee__c makeEmployeeRecord = DataFactory.makeEmployeeRecord('Ayush', 'patialayush3@gmail.com', '7876054795');
            insert makeEmployeeRecord;
            Leave__c makeLeaveRecord = DataFactory.makeLeaveRecord(makeEmployeeRecord.Id, 'I am ill', 'Pending');
            insert makeLeaveRecord;
        }
  
    }
}
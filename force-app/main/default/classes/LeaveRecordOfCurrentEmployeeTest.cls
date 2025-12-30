/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class LeaveRecordOfCurrentEmployeeTest {
    @TestSetup
    static void makeData(){
        Employee__c employee = new Employee__c();
        employee.Name = 'Ayush';
        employee.Email_Address__c = 'kalarawat38@mail.com';
        employee.Date_of_Birth__c = Date.newInstance(2002,12,12);
        employee.Primary_Number__c = '9251757505';
        employee.Emergency_Contact_Number__c = '8104465783';
        employee.Joining_Date__c = Date.newInstance(2024,06,03);
        insert employee;

        Leave__c leave = new Leave__c();
        leave.Employee_Name__c = employee.id;
        leave.Leave_Status__c = 'Pending';
        leave.Leave_Type__c = 'CL';
        leave.Leave_Reason__c   = 'Personal Work';
        insert leave;
    }

    @isTest
    static void myUnitTest() {
        List<Leave__c> listOfLeave = [SELECT  ID ,Employee_Name__r.Name,Total_Balance__c FROM Leave__c WHERE Leave_Status__c = 'Pending' ];
        Test.startTest();
        LeaveRecordOfCurrentEmployee.getLeaveRecord();
        Test.stopTest();
        
        System.assertEquals(1,listOfLeave.size(),'Should Insert Records');
    }
}
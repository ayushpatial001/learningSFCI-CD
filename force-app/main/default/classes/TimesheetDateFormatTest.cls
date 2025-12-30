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
private class TimesheetDateFormatTest {



    @TestSetup
    static void makeData(){
        User u = [Select Id From User Where LastName = 'Garg'];

        Employee__c emp = new Employee__c();
        emp.Name =  'Harshvandhan';
        emp.Joining_Date__c = System.today().addDays(-50);
        emp.Date_of_Birth__c = System.today().addDays(-200);
        emp.Email_Address__c = 'asah12@gmail.com';
        emp.Primary_Number__c = '9805938496';
        insert emp;

        Project__c proj = new Project__c();
        proj.Employee_Name__c = emp.Id;
        proj.Name = 'test1';
        proj.Project_Manager__c = u.Id;
        proj.Project_Start_Date__c = System.today();
        proj.Project_End_Date__c  = System.today().addDays(20);
        insert proj;

        Timesheet__c tim = new Timesheet__c();
        tim.Employee_Name__c = emp.Id;
        tim.Project__c = proj.Id;
        tim.Start_Project_Date__c  = DateTime.newInstance(2024, 7, 11, 4, 12, 30);
        tim.End_Project_Date__c =  DateTime.newInstance(2024, 7, 11,  6, 10, 30);
        tim.Description__c = 'This is for valid testing purpose';
        insert tim;


    }

    @isTest
    static void myUnitTest() {
        List<Timesheet__c> timesheetList = [select Name ,Employee_Name__r.Name , CreatedDate FROM Timesheet__c  limit 1];
       
        Test.startTest();
        TimesheetDateFormat.getTimesheetRecords();
        Test.stopTest();
        System.assertEquals(1, timesheetList.size());
    }
}
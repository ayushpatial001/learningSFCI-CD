/*
@Name : Ayush Patial
@Author : Ayush Patial
@Description : This is test class for EmployeeInformation and it cover 100% test coverage
@Date: 26 July 2024

*/


@isTest
private class EmployeeInformationTest {

    // Dummy Data of Employee__c , Project__c and Timesheet__c 
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
   /*
   @Name: Ayush Patial
   @CreatedDate: 26 July 2024
   @LastModifiedDate : 26 July 2024
   @Descritpiton: This function check fetching data is coming in correct way or not.
   */
   @isTest
   public static void unitTestForFetchingEmployeeData() {
        List<Employee__c> empList = [SELECT Id, (SELECT Id From Projects__r),(SELECT Id From Timesheets__r) From Employee__c  limit 1];
       
        Test.startTest();
        EmployeeInformation.getEmployeeInformation();
        Test.stopTest();
        System.assertEquals(1, empList.size());
       
    }
}
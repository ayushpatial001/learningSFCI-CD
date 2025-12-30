/*
@Name: Ayush Patial
@Author: Ayush Patial
@Description: This class is using Wrapper class to store multiple data .
@Date: 25 July 2024

*/

public with sharing class EmployeeInformation {
    
/*
  
@AuthorName: Ayush Patial
@Created Date: 24 July 2024
@Last ModifiedDate: 24 July 2024
@Last ModifiedBy: Ayush Patial
@Description: Method to Fetch Employee Information.

*/

    public static List<WrapperClass> getEmployeeInformation(){
        List<WrapperClass> listOfInformation = new  List<WrapperClass>();
        for(Employee__c empRecord :  [SELECT Id,Name, (SELECT Id From Projects__r),(SELECT Id From Timesheets__r) From Employee__c WHERE Active__c = True limit 10]){
            listOfInformation.add( new WrapperClass(empRecord,empRecord.Projects__r.size(),empRecord.Timesheets__r.size()));
            System.debug(listOfInformation);
        }
        
        return listOfInformation;
    }
    
    // This is the wrapper class to store employee data related to its projects and timesheet
    public class WrapperClass{
       public Employee__c empRecord;
       public Integer totalNoProjects = 0;
       public Integer totalNoTimesheet = 0;
       public String employeeName = '';


      public  WrapperClass(Employee__c empRecord, Integer totalNoProjects, Integer totalNoTimesheet){
             this.empRecord = empRecord;
             this.totalNoProjects = totalNoProjects;
             this.totalNoTimesheet  = totalNoTimesheet;
             this.employeeName = empRecord.Name;
       }


    }
}
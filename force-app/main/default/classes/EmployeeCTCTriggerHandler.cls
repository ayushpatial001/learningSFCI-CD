/*
@Name : EmployeeCTCTriggerHandler.apxc
@Author : Ayush Patial
@Date : 30 July 2024
@Descripion : This class is work on leave trigger name as LeaveTrigger
*/

public class EmployeeCTCTriggerHandler {
    
    /*
@Author : Ayush Patial
@CreatedDate : 30 July 2024
@Description : This method fill value based on checkbox values
@LastModifiedBy : Ayush Patial
*/
    
    public static void onBeforeInsertAndUpdate(List<Employee_CTC__c> listOfRecords){
        if(!listOfRecords.isEmpty()){
            for(Employee_CTC__c employeeRecords : listOfRecords){
                
                if(employeeRecords.Basic_Salary__c <= 15000){
                    if(employeeRecords.Employee_EPF__c){              
                        employeeRecords.Employee_EPF1__c = (employeeRecords.Basic_Salary__c * 12) /100;    
                    }
                    if(employeeRecords.Employer_EPF__c){
                        employeeRecords.Employer_EPF1__c = (employeeRecords.Basic_Salary__c * 12) /100;
                    } 
                    
                }
                else{
                     if(employeeRecords.Basic_Salary__c > 15000) {
                    if(employeeRecords.Employee_EPF__c){
                        employeeRecords.Employee_EPF1__c = 1800;
                    }
                    if(employeeRecords.Employer_EPF__c){
                        employeeRecords.Employer_EPF1__c = 1800;
                    }
                }

                }
                
                              if(employeeRecords.ESIC__c){
                    employeeRecords.ESIC1__c = (employeeRecords.Gross_Salary__c * 0.75)/100;
                    
                }
            }
        }
    }
    
}
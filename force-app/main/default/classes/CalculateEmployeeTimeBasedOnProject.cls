/*

@Name: Ayush Patial
@Author: Ayush Patial
@Description: This Class used for calculate total hour's of employee that he devote on a particular project.
@Date: 20 July 2024

*/




public class CalculateEmployeeTimeBasedOnProject {
    
    /*
@Author : Ayush Patial
@Description : In calculateTotalHours function I perform 2 queries on Employee , Timesheet and Project Objects.
*/
    
    public static void calculateTotalHours(){
        
        //Q2 Find TotalHour of Timesheet related To particular project of Employee.
        
        List<Employee__c> listOfEmployeeProject = [SELECT Id, Name , (SELECT Id, Name, (SELECT Total_Hours__c From Timesheets__r) From Projects__r) FROM Employee__c ];
        //List<Project__c> listOfProject = [SELECT Id, Name, (SELECT Total_Hours__c From Timesheets__r) From Projects__r WHERE Employee__r.Id =: listOfEmployeeProject ];
        //List<Timesheet__c> listOfTimesheet =
        Decimal totalHous = 0;
        for(Employee__c  empProj : listOfEmployeeProject){
            List<Project__c> listOfRelatedProject = empProj.Projects__r;
            for(Project__c projName: listOfRelatedProject ){
                List<Timesheet__c> listOfProjectRelatedTimesheet = projName.Timesheets__r;
                for(Timesheet__c hrs : listOfProjectRelatedTimesheet){
                    totalHous += hrs.Total_Hours__c;
                }
                System.debug('Employee Name-->'+ empProj.Name +  ': '+ ' Project--> '+ projName.Name + ':' + ' TotalHours--> ' + totalHous );
                totalHous =0;
            }
            
        }
        
        //Q1 Fetch the Employee with total hours of timesheet entries.
        
        List<Employee__c> employeesRecord  = [SELECT Name, (SELECT Total_Hours__c FROM Timesheets__r) FROM Employee__c ];
        Decimal hoursTotal =0;
        
        for(Employee__c emp : employeesRecord){
            List<Timesheet__c> totalHourOfTimesheet = emp.Timesheets__r;
            for(Timesheet__c timeOfTimesheet : totalHourOfTimesheet){
                hoursTotal += timeOfTimesheet.Total_Hours__c;
            }
            System.debug('Employee Name : ' + emp.Name + 'TotalHours-->' + hoursTotal);
            hoursTotal = 0;
            
        }
        
        //Q3 Create an Apex Class to sum of all the opportunity ammout associates with the particular account.
        
        List<AggregateResult> sumOfOpportunities = [SELECT  Account.Name , SUM(Amount) sum FROM Opportunity WHERE Account.Name != Null  GROUP BY Account.Name limit 5];
        for(AggregateResult result: sumOfOpportunities){
            System.debug(' Account Name--> '+ result.get('Name') + ' : ' +' TotalSum--> '+ result.get('sum') );
        }
        
        
        //Q4 Apply Aggregate function to use in time sheet
        
        List<AggregateResult> sumOfTimesheet = [SELECT SUM(Total_Hours__c) sum ,	Employee_Name__c FROM Timesheet__c GROUP BY Employee_Name__c ];
        for(AggregateResult result : sumOfTimesheet){
            
            System.debug('Employee Name--> '+ result.get('Employee_Name__c')+ ':' + 'TotalHours--> '+ result.get('sum'));
        }
        
        
        
        // Create an Apex Class to find any employee whose match the name in the string and records must have the last name Gaurav Sharma.
        
        List<List<SObject>> findEmployeeRecord = [Find 'Gaurav_Sharma' IN Name FIELDS Returning Employee__c];
        
        List<Employee__c> listOfEmployeeRecord = findEmployeeRecord[0];
        System.debug(listOfEmployeeRecord);
        
        
        
        
        // FIND John Smith IN Name Fields RETURNING lead(name, phone)
        
        List<List<Sobject>> findLeadRecord = [FIND 'John_Smith' IN Name Fields Returning lead(name,phone)];
        
        List<Lead> listOfLead = findLeadRecord[0];
        for(Lead resLead : listOfLead){
            System.debug('Lead Name -->' + resLead.Name);
            System.debug('Phone Number  -->' + resLead.phone);
        }
        
        //SOSL to search ‘Test’ text in all fields and return Account Object’s name, industry and Contact Object’s name, email as result.
        
        List<List<SObject>> finsAccountAndContact = [Find 'Test' IN Name FIELDS Returning Account(Id,Name,Industry), Contact(Name,Email)];
        List<Account> listOfAccount = finsAccountAndContact[0];
        List<Contact> listOfContact = finsAccountAndContact[1];
        for(Account resAcc : listOfAccount){
            System.debug('Account Name -->' + resAcc.Name);
            System.debug('Industry  -->' + resAcc.Industry);
        }
        
        for(Contact resCon : listOfContact){
            System.debug('Contact Name -->' + resCon.Name);
            System.debug('Eamil -->' + resCon.Email);
        }
        
        
        // write an SOQL Query to count the all active employees where Salesforce Certification checkbox is true.
        
        List<AggregateResult> countNoOfEmployee = [SELECT COUNT(Id) FROM Employee__c WHERE Active__c = TRUE AND Salesforce_Experience__c = TRUE GROUP BY Name ];
        System.debug('Total Count -->'+ countNoOfEmployee);
        
        // Retrieve the top 3 Opportunities with the highest Amount for each Account By Aggregate Function
        
        List<AggregateResult> listOfOpportunity = [SELECT  Account.Name , MAX(Amount) amt FROM Opportunity WHERE Account.Name != Null  GROUP BY Account.Name limit 3];
        for(AggregateResult rec : listOfOpportunity){
            System.debug('Account Name-->' + rec.get('Name') + 'Max Amount Opportunity -->' + rec.get('amt') );
        }
        
        
        
    }
}
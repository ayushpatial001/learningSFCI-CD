/*
@Name: Ayush Patial
@Author: Ayush Patial
@Description: This class is used to perform SOSL Queries.
@Date: 22 July 2024

*/



public class UderstandingSOSL {
    /*
@Name: Ayush Patial
@Description: In This Method I perform 3 Queries related to SOSL.
*/
    public static void performQueries(){
        
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
        
        /* for(List<SObject> result : finsAccountAndContact){
for(Sobject find : result){
System.debug('The list -->' + find );  
}

}*/
        
        // FIND John Smith IN Name Fields RETURNING lead(name, phone)
        
        // List<List<Sobject>> findLeadRecord = [FIND 'John_Smith' IN Name Fields Returning lead(name,phone)];
        
        // List<Lead> listOfLead = findLeadRecord[0];
        // for(Lead resLead : listOfLead){
        //    System.debug('Lead Name -->' + resLead.Name);
        //   System.debug('Phone Number  -->' + resLead.phone);
        // }
        
        /*for(List<SObject> result1 : findLeadRecord){
for(Sobject find : result1){
System.debug('Lead Record Whose Name Is John Smith --> ' + find );
}

}*/
        
        //Create an Apex Class to find any employee whose match the name in the string and records must have the last name Gaurav Sharma.
        
        //List<List<SObject>> findEmployeeRecord = [Find 'Gaurav_Sharma' IN Name FIELDS Returning Employee__c];
        
        // List<Employee__c> listOfEmployeeRecord = findEmployeeRecord[0];
        // System.debug(listOfEmployeeRecord);
        
        
        // write an SOQL Query to count the all active employees where Salesforce Certification checkbox is true.
        
        List<AggregateResult> countNoOfEmployee = [SELECT COUNT(Id) FROM Employee__c WHERE Active__c = TRUE AND Salesforce_Experience__c = TRUE GROUP BY Name ];
        System.debug('Total Count -->'+ countNoOfEmployee);
        
        
        // Get Timesheet Record For Employee Record
        
        /*Map<Id,List<Project__c>> mapOFEmployeeRelatedToItsProjects =  new  Map<Id, List<Project__c>>();
Map<Id ,List<Timesheet__c>> mapOfTimesheetRelatedToItsProjects = new Map<Id , List<Timesheet__c>>();
for(Employee__c rec : [Select Id, Name , (SELECT Id,Name,(Select Id,name ) From Projects__r)From Employee__c]){
if(mapOFEmployeeRelatedToItsProjects.containsKey(rec.Id)){
//  mapOFEmployeeRelatedToItsProjects.put(rec.ID , new List<Employee__c>{rec});
System.debug('If There Is Project -->' + mapOFEmployeeRelatedToItsProjects);
mapOFEmployeeRelatedToItsProjects.get(rec.Id).add(rec.projects__r);
}else{
mapOFEmployeeRelatedToItsProjects.put(rec.Id,new List<Project__c>{rec.projects__r});
}
}*/
    }
    
    public static void mapAllocations(){
        
        // create an apex class to fetch all the reimbursement record based on the employee where status is Pending and Use Map Collection.
         
        Map<String, List<Reimbursement__c>>  mapOfReimbursementRealtedToEmployee = new Map<String, List<Reimbursement__c>>();
        for(Reimbursement__c rec : [SELECT 	Employee_Name__r.Name, Name FROM Reimbursement__c Where 	Status__c = 'Pending']){
            if(!mapOfReimbursementRealtedToEmployee.containsKey(rec.Employee_Name__r.Name)){
                mapOfReimbursementRealtedToEmployee.put(rec.Employee_Name__r.Name , new List<Reimbursement__c>{rec});
                
            } else {
                mapOfReimbursementRealtedToEmployee.get(rec.Employee_Name__r.Name).add(rec); 
                
                
            }
        }
        for(String key: mapOfReimbursementRealtedToEmployee.keyset()){
            System.debug('Employee Name--> '+ key);
            System.debug('Reimbursement Record -->'+ mapOfReimbursementRealtedToEmployee.get(key));
        }
        
        
        // Create an apex class to fetch all the Leave record based on the current logged in employees where status is Pending and store it in the Collection.
        
        String getCurrentEmailId = UserInfo.getUserEmail();
        
        Map<String, List<Leave__c>> mapOfEmployeeNameWithLeave = new  Map<String, List<Leave__c>>();
        
        for(Leave__c getRecord  :  [SELECT Employee_Name__r.Name,	Name,	Leave_Type__c,	Leave_Reason__c,	Leave_Status__c FROM Leave__c WHERE Employee_Name__r.Email_Address__c =: getCurrentEmailId]){
            
            if(!mapOfEmployeeNameWithLeave.containsKey(getRecord.Employee_Name__r.Name)){
                
                mapOfEmployeeNameWithLeave.put(getRecord.Employee_Name__r.Name , new List<Leave__c>{getRecord}); 
                
            } else {
                
                mapOfEmployeeNameWithLeave.get(getRecord.Employee_Name__r.Name).add(getRecord); 
                
                
            }
        }
        
        for(String key: mapOfEmployeeNameWithLeave.keyset()){
            System.debug('Employee Name--> '+ key);
            System.debug('Leave Record -->'+ mapOfEmployeeNameWithLeave.get(key));
        }
        
        
        //  Create an apex class to fetch the employees with the timesheet of last 3 months.
        Map<String, List<Timesheet__c>> mapOfEmployeeNameWithTimesheet = new  Map<String, List<Timesheet__c>>();
        
        for(Timesheet__c getRecord1  :  [SELECT Employee_Name__r.Name,	Name,	Total_Hours__C, CreatedDate FROM Timesheet__c WHERE CreatedDate <= LAST_N_WEEKS:12 ]){
            
            if(!mapOfEmployeeNameWithTimesheet.containsKey(getRecord1.Employee_Name__r.Name)){
                
                mapOfEmployeeNameWithTimesheet.put(getRecord1.Employee_Name__r.Name , new List<Timesheet__c>{getRecord1}); 
                
            } else {
                
                mapOfEmployeeNameWithTimesheet.get(getRecord1.Employee_Name__r.Name).add(getRecord1); 
                
                
            }
        }
        
        for(String key: mapOfEmployeeNameWithLeave.keyset()){
            System.debug('Employee Name--> '+ key);
            System.debug('Leave Record -->'+ mapOfEmployeeNameWithLeave.get(key));
        }
        
    } 
    
    /* public static void complexityReduce(){
Decimal test =0;
//Get Total Hours OF Timesheet with that particular project and particular employee
List<Employee__c> listOfEmployeeRecord = [SELECT Id From Employee__c WHERE 	Active__c = True];
List<Project__c> listOfProjectWithRelatedEmployee = [SELECT Id,Name From Project__c WHERE Employee_Name__c =: listOfEmployeeRecord];
List<Timesheet__c> listOfTimesheetRelatedToProject = [SELECT Total_Hours__c FROM Timesheet__c WHERE Project__c =: listOfProjectWithRelatedEmployee];
for(Timesheet__c sds : listOfTimesheetRelatedToProject){
test += sds.Total_Hours__c;
System.debug(test);
}

} */
    
    /* public static void mapTry(){

Map<Id, Map<Id,List<Timesheet__c>>> tryToSortComplexity = new Map<Id, Map<Id,List<Timesheet__c>>>();
for(Employee__c result : [SELECT Id, Name , (SELECT Id, Name, (SELECT Total_Hours__c From Timesheets__r) From Projects__r) FROM Employee__c ]){

}

} */
    
    
    
    
    
    
}
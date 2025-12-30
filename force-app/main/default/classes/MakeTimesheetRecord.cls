public with sharing class MakeTimesheetRecord {
    
    @AuraEnabled
    public static Id makeTimesheet(Id EmployeeId, Id projectId, String description, Integer totalHour){  
        Timesheet__c makeT = new Timesheet__c();
        makeT.Employee_Name__c = EmployeeId;
        makeT.Hours__c = totalHour;
        makeT.Project__c = projectId;
        makeT.Description__c =  description;

        

        try{
            insert  makeT;

        }catch(DmlException e){
            System.debug('there is some error'+e);
        }
        Timesheet__c makedd = [Select Id From Timesheet__c ORDER BY CreatedDate DESC Limit 1];

        return makedd.Id;



    }
}
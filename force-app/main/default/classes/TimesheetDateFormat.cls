/*
@Name: Ayush Patial
@Author: Ayush Patial
@Description: This class is using wrapper class to bind the data.
@Date: 25 July 2024
*/


public with sharing class TimesheetDateFormat {
    


    // Wrapper class to hold Timesheet record and formatted date
    public class TimesheetWrapper {
        public String timesheetName = ''; 
        public String employeeName = '';
        public  String formattedCreatedDate = '';
        /*public TimesheetWrapper(Timesheet__c c) {
            this.timesheet = c;
            this.formattedCreatedDate = timesheet.createdDate.format('dd-MMMM-yyyy');            
        } */       
    }
    
    
/*
@AuthorName: Ayush Patial
@Created Date: 25 July 2024
@Last ModifiedDate: 25 July 2024
@Last ModifiedBy: Ayush Patial
@Description: Method to fetch Timesheet records with formatted dates

*/
    
   
    public static List<TimesheetWrapper> getTimesheetRecords(){
        List<TimesheetWrapper> listOfWrappers = new List<TimesheetWrapper>();  
        TimesheetWrapper obj = new TimesheetWrapper();
        for(Timesheet__c ts : [select 	Name ,	Employee_Name__r.Name , CreatedDate FROM Timesheet__c  limit 5]) {            
                    obj.timesheetName = ts.Name;
                    obj.employeeName = ts.Employee_Name__r.Name;
                    obj.formattedCreatedDate = ts.CreatedDate.format('dd-MMMM-yyyy');
                    listOfWrappers.add(obj);
                    System.debug(listOfWrappers); 
        }
        
              
        return listOfWrappers;
        
    }
    
}
/*
@Name : EmployeeTriigerHandler.apxc
@Author : Ayush Patial
@Descritpiton: This class work on Employee Trigger
*/

public class EmployeeTriggerHandler {
    
    /*
@Name : Ayush Patial
@CreatedDate : 30 July 2024
@Descritpiton: This method fetch email of the user on the basis of employee email and change the isActive field in user if employee is inactive
*/
    
    public static void onAfterInsertAndUpdate(List<Employee__c> listOfRecord){
        List<String> emailOfEmployee = new List<String>();
        
        for(Employee__c empRecord : listOfRecord){
            if(empRecord.Active__c == False){
                emailOfEmployee.add(empRecord.Email_Address__c);
            }
            
        }
        
        List<User> userRelatedToEmployee =  [Select Id , Name ,Email,  IsActive From User Where Email IN : emailOfEmployee];
        List<User> changesOnUser = new List<User>();
        
        
        for(User userRecord : userRelatedToEmployee){
            User makeRecord = new User();
            makeRecord.Id = userRecord.Id;
            makeRecord.IsActive = False;
            changesOnUser.add(makeRecord);
        }
        
        try{
            update changesOnUser;
        }catch(DMLException e){
            System.debug(e.getmessage() + e.getLineNumber());
        }catch(Exception e){
            System.debug(e.getmessage() + e.getLineNumber()); 
        }
    }
    
}
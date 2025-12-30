@isTest
public class GenerateEmployeeNameOnLeaveTest {
    
    
    @TestSetup
    static void makeDate(){
        
        User userRecord = DataFactory.createUser('Standard Platform User','ayuPat','mukesh32@gmail.com','Patial','ayush123paital@gmail.com');
        try{
            insert userRecord;
        }catch(Exception e){
            System.debug(e.getMessage());
        }
        
        
        System.runAs(userRecord){
            Employee__c employeeData  =  DataFactory.makeEmployeeRecord('Abhishek', 'mukesh32@gmail.com', '7876054795');
            try{
                insert employeeData;
            }catch(Exception e){
            	System.debug(e.getMessage());
       		}
            
            Leave__c leaveData = DataFactory.makeLeaveRecord(employeeData.Id, 'this is due to', 'Pending');
            try{
                insert leaveData;
            }catch(Exception e){
            	System.debug(e.getMessage());
       		}
            
        }
    }
    
    @isTest
    static void myPostiveTest(){
        User getUserRecord = [SELECT Alias,Email,LastName,UserName FROM User WHERE Email = 'mukesh32@gmail.com'];
        
        Employee__C getEmployeeRecord = [SELECT Name,Email_Address__c,Primary_Number__c,Employee_Code__c FROM Employee__c WHERE Email_Address__c = 'mukesh32@gmail.com'];
        
        
        List<Leave__c> nameOfEmployee = [SELECT  Employee_Name__c FROM Leave__c];
        
        System.assertEquals(getEmployeeRecord.Id, nameOfEmployee[0].Employee_Name__c);
        
        
        
    }
    
}
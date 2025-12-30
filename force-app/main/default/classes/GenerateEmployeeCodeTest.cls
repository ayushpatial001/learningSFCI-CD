@isTest
public class GenerateEmployeeCodeTest {
    
    @TestSetup
    static void makeData(){
        Integer i =1;
        
        String code = 'TMC-' + System.today().year() + '-'+i;
        
        Employee__c employeeData  =  DataFactory.makeEmployeeRecord('Abhishek', 'mukesh12@gmail.com', '7876054795');
        Employee__c employeeData2  =  DataFactory.makeEmployeeRecord('Nityash', 'nityash1@gmail.com', '7876054795');
        
        try{
            insert employeeData;
        }catch(DmlException e){
            System.debug(e.getMessage());
        }
        try{
            insert employeeData2;
        }catch(DmlException e){
            System.debug(e.getMessage());
        }
        
        System.debug(employeeData.Employee_Code__c);
        
    }
    
    
    @isTest
    public static void myPostiveTest(){
        
        
        Employee__c insertedData = [SELECT Employee_Code__c, CreatedDate FROM Employee__c ORDER BY CreatedDate];
        
        System.assertEquals('TMC-2024-2',insertedData.Employee_Code__c);
    }
    
}
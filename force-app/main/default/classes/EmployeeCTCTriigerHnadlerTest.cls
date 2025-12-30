@isTest
public class EmployeeCTCTriigerHnadlerTest {
    
    @TestSetup
    static void makeData(){
        Employee__c record = DataFactory.makeEmployeeRecord('Rajat', 'rajat12@gmail.com', '7876054795');
        insert record;
        Employee__c record1 = DataFactory.makeEmployeeRecord('Verma', 'rajat12@gmail.com', '7876054795');
        insert record1;
        try{
              Employee_CTC__c makeRecord2 = DataFactory.createRecord(record.Id,True, True , True , 10000,2000);
          insert makeRecord2;
        Employee_CTC__c makeRecord3 = DataFactory.createRecord(record1.Id, True, True, False, 15700,3000);
            insert makeRecord3;
        }catch(DMLException e){
            System.debug(e.getmessage());
        }
              
  
    }
    
    @isTest
    static void myPositiveTestCase(){
         List<Employee__c> fetchEmployeeRecord = [SELECT Id, Name FROM Employee__c];
        System.debug(fetchEmployeeRecord);
        List<Employee_CTC__c> fetchRecord = [SELECT Id, Employee_Name__r.Name, Employee_EPF__c,  ESIC__c,  Employer_EPF1__c, ESIC1__c, Basic_Salary__c FROM Employee_CTC__c ];
        System.debug(fetchRecord);
        //System.assertEquals(1,fetchRecord.size());
    }

}
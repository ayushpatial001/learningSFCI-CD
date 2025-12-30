@isTest
public class BirthdayNotifySchedulerTestClass {
    
    @TestSetup
    public static void makeData(){
           List<Employee__c>  listOFemployeeRecord = new List<Employee__c>();
        for(Integer i=0;i<5;i++){
            Employee__c  newEmployee = DataFactory.makeEmployeeRecord('Ayush'+i, 'patialayush3@gmail.com', '7876054795');
            listOFemployeeRecord.add(newEmployee);
         }
        insert listOFemployeeRecord;
        Account accRecord = DataFactory.createAccount('Account1', False, '123456789012345678');
        insert accRecord;
        
        Contact conRecord = DataFactory.createContact(accRecord.Id, 'Last', 'patialayush3@gmail.com', 'this si the month');
        insert conRecord;
        
      
    }
    	
    @isTest
    public static void makePositiveTest(){
      List<Employee__c> getEmployeeData = [Select Id, Name, Date_of_Birth__c,Email_Address__c From Employee__c];
      Test.StartTest();
        String CRON_EXP = '0 0 0 15 3 ? 2042';
        System.Schedule('Scheudle',CRON_EXP,new BirthdayNotifySchedulerClass());
      Test.StopTest();
    
    }

}
/**
* This class contains unit tests for validating the behavior of Apex classes
* and triggers.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an org are executed whenever Apex code is deployed
* to a production org to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production org. In addition, all triggers must have some code coverage.
* 
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the org size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
@isTest
private class ReimbursementFetchTest {
   @TestSetup
   static void makeData(){
       Reimbursement__c reimbursement  = new Reimbursement__c();
       reimbursement.Employee_Name__c = 'Ayush';
       reimbursement.Type__c = 'Travel';
       reimbursement.Amount__c = 8000;
       reimbursement.From_Date__c= Date.newInstance(2024,07,28);
       reimbursement.To_Date__c = Date.newInstance(2024,07,29);
       reimbursement.Status__c = 'Pending';
       reimbursement.Receipt__c = True;
       insert reimbursement;

   }

   @isTest
   static void myPositiveUnitTest() {       
      List<Reimbursement__c> listOfReimbursement = [SELECT Name FROM Reimbursement__c WHERE Status__c ='Pending' ];
      Test.startTest();
      ReimbursementFetch.fetchReimbRecords();
      Test.stopTest();
      System.assertEquals(1,listOfReimbursement.size());
   }
}
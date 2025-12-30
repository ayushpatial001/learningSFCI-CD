@isTest
public class OpportunityTriggerHnadlerEmailTest {
    
    @TestSetup
    static void makeData(){
        Account acc1 = DataFactory.createAccount('asf', False, '123456789012345678');
        insert acc1;
        Opportunity app1 = DataFactory.createOpportunityRecord(acc1.Id, 'oop1','ad@gmsil');
        insert app1;
        Opportunity app2 = DataFactory.createOpportunityRecord(acc1.Id, 'oop1','er@gmsil');
        insert app2;
        
        
        
    }
    @isTest
    static void myPositiveTest(){
        List<Opportunity> checkOpp = [SELECT Id , Email__c From Opportunity];
        Opportunity oppRecord1 = (Opportunity) checkopp[0];
        
        oppRecord1.Email__c = 'fds@gmail';
        update oppRecord1;
        System.assertEquals('fds@gmail',oppRecord1.Email__c);
        
        
    }

}
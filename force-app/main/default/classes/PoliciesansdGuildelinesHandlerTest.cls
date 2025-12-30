@isTest
public class PoliciesansdGuildelinesHandlerTest {
    
    @TestSetup
    static void makeData(){
       Policies_and_Guidelines__c newPolicy = DataFactory.createNewPolicy('Testing Policy','This is New Policy',1.0,'Accepted');
        
       insert newPolicy;
    
    }
    
    @isTest
    public static void myPositiveCases(){
        
        List<Policies_and_Guidelines__c>  getMakeData = [Select Id, Policy_Name__c,Description__c,Version__c From Policies_and_Guidelines__c];        
        System.assertEquals(1,getMakeData.size());
    }

}
public with sharing class AccountRelatedContactCaseOpportunities {
   
    @AuraEnabled(cacheable=true)
    public static Account getRelatedInformation(String accountId){

        

           try{
            return [Select Id, Name,(Select Name From Contacts), (Select Name From Opportunities),(Select Id From Cases) From Account Where Id =: accountId LIMIT 1];

           }catch(Exception e){
                throw new  AuraHandledException('There is some error occur in the query');
           }

    }
}
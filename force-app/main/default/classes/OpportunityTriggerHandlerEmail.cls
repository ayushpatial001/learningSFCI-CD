public class OpportunityTriggerHandlerEmail {
    
    public static void emailChangeOnOpportunity(List<Opportunity> listOfNewOpportuinty, Map<Id, Opportunity> mapOfoldOpportunity){
        Set<Id> setOfAccountId= new Set<Id>();
        
        
        String storeNewEmail = '';
        for(Opportunity oppRecord : listOfNewOpportuinty){
            if(oppRecord.Email__c != mapOfoldOpportunity.get(oppRecord.Id).Email__c){
                 setOfAccountId.add(oppRecord.AccountId);
                System.debug('old email-->'+ oppRecord.Email__c );
                System.debug('new email-->'+ mapOfoldOpportunity.get(oppRecord.Id).Email__c);
                storeNewEmail = oppRecord.Email__c;
            }
        }
        
        if(!setOfAccountId.isEmpty()){
            List<Opportunity> listOfSameOwnerOpportunity = [SELECT Id, Email__c FROM Opportunity Where  AccountId IN : setOfAccountId];
        System.debug(listOfSameOwnerOpportunity);
        
        List<Opportunity> listToStore = new List<Opportunity>();
        for(Opportunity changeEmail : listOfSameOwnerOpportunity){
                changeEmail.Email__c = storeNewEmail;
               listToStore.add(changeEmail);
            System.debug('Value of new list-->'+ listToStore);
            
        }
        
        try{
            if(!listToStore.isEmpty()){
                 update listToStore;
            }
           
        }catch(DMLException e){
            System.debug(e.getmessage());
        }
        
        }
        
    }

}
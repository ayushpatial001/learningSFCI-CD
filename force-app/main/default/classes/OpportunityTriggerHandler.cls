/*

@Name: OpportuintyTriggerHandler.apxc
@Author Name : Ayush Patial
@Description : This class have two method one is run onbefore and other is run onAfter when opportunitytrigger is fired
@CreatedDate : 2 August 2024

*/

public class OpportunityTriggerHandler {
    
    /*
@Name: Ayush Patial
@Description : This method work on custom stage field to update onbefore
@LastModified On : 1 August 2024

*/    
    // Implement an Apex trigger to prevent the creation of a new Opportunity if the associated Account does not have a Billing Address.
    
    public static void onBefore(List<Opportunity> listOfOpportunity){
        Set<Id> setOfAccountId = new Set<Id>();
        for(Opportunity oppRecords : listOfOpportunity){
            setOfAccountId.add(oppRecords.AccountId);
        }
        
        List<Account> listOfRelatedAccount = [SELECT ID, BillingCity FROM Account WHERE Id IN : setOfAccountId AND BillingCity = null];
        
        for(Opportunity record : listOfOpportunity){
            if(listOfRelatedAccount.size() > 0){
                record.addError('You dont create Opportunity because of account ');
            }
            if(record.Custom_Stage__c  == null){
                record.Custom_Stage__c = 'Record Is Created';
            }else if(record.Custom_Stage__c != null){
                record.Custom_Stage__c = 'Record is Updated';
            }
            
        }
    }
    
    /*
@Name: Ayush Patial
@Description : This method work to calculate sum of amount of total opportuinty when a new opportuinty is created
@LastModified On : 1 August 2024

*/ 
    
    public static void onAfter(Map<Id ,Opportunity> oldOppMap){
        System.debug(oldOppMap);
        Set<Id> setOfAccountId = new Set<Id>(); 
        for(Id key : oldOppMap.keySet()){
            system.debug('containsKey' + oldOppMap.containsKey(key));
            setOfAccountId.add(oldOppMap.get(key).AccountId);
            
        }
        System.debug(setOfAccountId);
        
        List<AggregateResult> listOfAccountId = [SELECT  AccountId accountId, Sum(Amount) sum FROM Opportunity WHERE AccountId IN : setOfAccountId GROUP BY AccountId ];
        System.debug('Result-->'+ listOfAccountId);
        List<Account> listOfAccount = new List<Account>();
        if(!listOfAccountId.isEmpty()){
            //Map<Id, Decimal> mapOfAmountWithSum = new Map<Id, Decimal>();
            
            for(AggregateResult rec : listOfAccountId){
                Id idValue = (Id)rec.get('accountId');
                Decimal sum = (Decimal)rec.get('sum');
                //mapOfAmountWithSum.put(idValue,sum);
                Account a = new Account (
                    Id = idValue,
                    Total_Opportunity_Amount__c =  sum  
                );
                listOfAccount.add(a);     
            }
        }else{
            for(Id i:setOfAccountId){
                Account a = new Account (
                    Id = i,
                    Total_Opportunity_Amount__c =  0
                );
                listOfAccount.add(a);   
            }
        }     
        
        
        if(listOfAccount.size() > 0){
            system.debug('listOfAccount' + listOfAccount);
            update listOfAccount;
        }
        
        
    }
    
}
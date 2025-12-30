trigger HighestOpp on Opportunity (After  insert, After update , After delete) {
    
    Set<Id> setOfAccountId = new Set<Id>();
     Map<Id,List<Opportunity>> mapOfOpportuintyOfRelatedAccount = new Map<Id,List<Opportunity>>();
    
    for(Opportunity op : Trigger.new){
        setOfAccountId.add(op.AccountId);
        if(String.isNotBlank(op.AccountId)){
              if(!mapOfOpportuintyOfRelatedAccount.containsKey(op.AccountId)){
                mapOfOpportuintyOfRelatedAccount.put(op.AccountId, new List<Opportunity>{op});
         }else{
            mapOfOpportuintyOfRelatedAccount.get(op.AccountId);
          }
        }
       
    }
    
    System.debug('mapOfOpportuintyOfRelatedAccount-->'+mapOfOpportuintyOfRelatedAccount);
    //Baiscally me AccountId ke sath ONLY Opportunity ke amount field store krbua taki unko lst me match krbasku
    
    Decimal max =0 ;
    Map<Id, Opportunity> mapOfOpportunity = new Map<Id, Opportunity>();
    for(Opportunity oppRecord : [
            SELECT Id, AccountId, Amount, Name 
            FROM Opportunity 
            WHERE AccountId IN : setOfAccountId AND Amount != NULL 
            ORDER BY Amount DESC
        ]){
          if (!mapOfOpportunity.containsKey(oppRecord.AccountId)) {
                mapOfOpportunity.put(oppRecord.AccountId, oppRecord);
            }    }

   
    
}
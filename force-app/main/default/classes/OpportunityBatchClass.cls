global class OpportunityBatchClass implements Database.Batchable<sObject> {
    //Start Method
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('Select Id,StageName from Opportunity Where CloseDate < Today AND StageName != \'Closed Won\'  ');
    }
    //Execute Method
    global void execute(Database.BatchableContext bc, List<Opportunity> listOfOpportunities)
    {  
        
        try{  
            for(Opportunity oppObj : listOfOpportunities)
            {
                oppObj.StageName ='Closed Lost';        
            }
            Database.SaveResult[] SaveResultList = Database.update(listOfOpportunities,false);
            
            System.debug(SaveResultList);
        }
        catch(Exception excep)
        {
            System.debug('Exception Occured=>'+excep.getMessage());
        }
    }
    //Finish Method
    global void finish(Database.BatchableContext bc){
        
    }
    
}
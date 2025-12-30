trigger OpportunityTrigger on Opportunity (before insert, before update,After insert, After update, After delete) {
    if(Trigger.isBefore){
           OpportunityTriggerHandler.onBefore(Trigger.new);
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
              OpportunityTriggerHandler.onAfter(Trigger.newMap);
        }
        if(Trigger.isUpdate){
           //  OpportunityTriggerHandler.onAfter(Trigger.newMap);
             OpportunityTriggerHandler.onAfter(Trigger.oldMap);
             OpportunityTriggerHandlerEmail.emailChangeOnOpportunity(Trigger.new, Trigger.oldMap);
            
        }
        if(Trigger.isDelete){
            OpportunityTriggerHandler.onAfter(Trigger.oldMap);
        }
        //if(Trigger.isInsert || Trigger.isUpdate){
         //    OpportunityTriggerHandler.onAfter(Trigger.newMap);
           
             
      //  }
        //if(Trigger.isDelete  || Trigger.isUpdate){
         //   OpportunityTriggerHandler.onAfter(Trigger.oldMap);
           
      //  }
        
    }
}
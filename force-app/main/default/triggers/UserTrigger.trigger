trigger UserTrigger on User (After insert, After update) {
     if(Trigger.isAfter)
     {
         if(Trigger.isInsert){
             UserTriggerHandler.onAfterInsert(Trigger.new);
         }
         if(Trigger.isUpdate){
            // UserTriggerHandler.onAfterUpdate(Trigger.new);
             UserTriggerHandler.AssignToManager(Trigger.oldMap);
         }
     }
      
}
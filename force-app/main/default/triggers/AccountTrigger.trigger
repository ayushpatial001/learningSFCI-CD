trigger AccountTrigger on Account (before insert, after insert, before delete,After update) {
    if(Trigger.isAfter && Trigger.isInsert)
    {     
        AccountTriggerHandler.onAfterInsert(Trigger.new);
     }
    if(Trigger.isBefore && Trigger.isDelete){
        AccountTriggerHandler.onBeforeDelete(Trigger.old);      
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        AccountTriggerHandler.onAfterUpdate(Trigger.new,Trigger.oldMap);
    }
}
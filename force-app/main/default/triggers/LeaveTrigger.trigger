/*
@Name : GenerateEmployeeNameOnLeave.apxt
@Author : Ayush Patial
@Description : This trigger set Employee__code automatically when new employee record is inserting
*/


trigger LeaveTrigger on Leave__c (before insert , After Update) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        LeaveTriggerHandler.onBeforeInsert(Trigger.new);
    }
    else if(Trigger.isAfter && Trigger.isUpdate){
        LeaveTriggerHandler.onAfterInsert(Trigger.new ,Trigger.oldMap);
    }
    
    
   
    
}
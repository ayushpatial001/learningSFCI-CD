trigger InterviewTrigger on Interview__c (After insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        InterviewTriggerHandler.onAfter(Trigger.new);
    }

}
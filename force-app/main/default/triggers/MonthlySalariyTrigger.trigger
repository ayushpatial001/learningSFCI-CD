trigger MonthlySalariyTrigger on Monthly_Salary__c (before insert) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        MonthlySalaryTriggerHandler.onBefore(Trigger.new);
    }

}
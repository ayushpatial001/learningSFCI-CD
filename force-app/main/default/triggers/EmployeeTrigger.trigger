trigger EmployeeTrigger on Employee__c (After insert, After update) {
    
    EmployeeTriggerHandler.onAfterInsertAndUpdate(Trigger.new);
        
    
}
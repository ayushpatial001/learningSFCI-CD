trigger EmployeeCTCTrigger on Employee_CTC__c (before insert , before update) {

    
    if(Trigger.isBefore && (Trigger.isInsert  || Trigger.isUpdate)){
        EmployeeCTCTriggerHandler.onBeforeInsertAndUpdate(Trigger.New);
    }
    
    
}
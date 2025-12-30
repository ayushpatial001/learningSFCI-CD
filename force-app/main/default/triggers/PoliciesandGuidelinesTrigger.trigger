trigger PoliciesandGuidelinesTrigger on Policies_and_Guidelines__c (After update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            PoliciesansdGuildelinesHandler.onAfter(Trigger.new,Trigger.oldMap);
        }

    }

}
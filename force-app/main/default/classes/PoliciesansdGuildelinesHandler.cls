public class PoliciesansdGuildelinesHandler {
    
    public static void onAfter(List<Policies_and_Guidelines__c> listofPolicy, Map<Id, Policies_and_Guidelines__c> mapOfPolicy){
        List<Policies_and_Guidelines__c> listOfUpdatedData = new List<Policies_and_Guidelines__c>();
        for(Policies_and_Guidelines__c rec : listofPolicy){
            if(rec.Description__c != mapOfPolicy.get(rec.Id).Description__c){
                Policies_and_Guidelines__c changeVersion = new Policies_and_Guidelines__c();
                changeVersion.Id = rec.Id;
                changeVersion.Version__c = rec.Version__c + 0.1;
                listOfUpdatedData.add(changeVersion);
            }
        }
        try{
            update listOfUpdatedData;
        }catch(DMLException e){
            System.debug(e.getmessage());
            System.debug(e.getLineNumber());
        }
    }

}
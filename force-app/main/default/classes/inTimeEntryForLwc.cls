public class inTimeEntryForLwc {
    
    public static void getcurrentUserTimeEntryDetail(){
        String currentId = UserInfo.getUserId();
        List<User> getUserEmail = [Select Id, Email From User Where Id =: currentId Limit 1];
        List<Employee__c> getEmployeeData =[Select Id, Email_Address__c From Employee__c Where Email_Address__c =: getUserEmail[0].Email];
        
    }

}
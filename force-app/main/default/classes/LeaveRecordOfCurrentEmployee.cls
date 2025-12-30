public class LeaveRecordOfCurrentEmployee {
    public static void getLeaveRecord(){
        
        String userEmail1 = UserInfo.getUserEmail() ;
        List<User> userEmail = [SELECT Email FROM User Where Email =: userEmail1 limit 1];
        System.debug(UserEmail);
        
        List<Leave__C> leaveRecordOfCurrentUser = [SELECT ID ,Employee_Name__r.Name,Total_Balance__c FROM Leave__c WHERE Employee_Name__r.Email_Address__c =: userEmail1 And Leave_Status__c = 'Pending'];
        for(Integer i =0 ;i<leaveRecordOfCurrentUser.size();i++){
            System.debug(leaveRecordOfCurrentUser[i]);
        }
        
        
        
    }
    
    
}
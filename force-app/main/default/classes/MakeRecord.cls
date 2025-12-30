public class MakeRecord {
    
    
    public MakeRecord(ApexPages.StandardController stdController) {
        System.debug('This is working with great performance');
    }
    
    public static void acceptedButton() {
        String currentPageId = ApexPages.currentpage().getparameters().get('Id');
        System.debug(currentPageId);
        List<Policies_and_Guidelines__c>  storethatdata = new List<Policies_and_Guidelines__c>();
        for(Policies_and_Guidelines__c getPolicyData : [Select Id , Status__c From  Policies_and_Guidelines__c Where Id =: currentPageId]){
            getPolicyData.Status__c = 'Accepted';
            storethatdata.add(getPolicyData);
            
        }
        try{
            update storethatdata;
        }catch(DMLException e){
            System.debug(e.getmessage());
        }
       
        //Get current user id
        String currentUserId = UserInfo.getUserId();
        System.debug(currentUserId);
        List<User> getUserEmail = [Select Id, Email From User WHere Id =: currentUserId limit 1];
        System.debug(getUserEmail);
        List<Employee__c> listOfEmployee = [Select Id, Name ,	Email_Address__c From Employee__c Where Email_Address__c =: getUserEmail[0].Email limit 1];
        System.debug(listOfEmployee[0].Name);
        
        List<Employee_Regarding_Policy__c>  empRegardingPolicy = [Select EmployeeName__c,Accepted_Policies__c,Remaining_Policies__c From Employee_Regarding_Policy__c Where EmployeeName__c =: listOfEmployee[0].Id limit 1];
        System.debug(empRegardingPolicy);
        
        if(empRegardingPolicy.size() > 0){
            try {
                List<Employee_Regarding_Policy__c> collectAllRecord = new List<Employee_Regarding_Policy__c>();
                for(Employee_Regarding_Policy__c makeRecord : empRegardingPolicy){
                    if(makeRecord.Accepted_Policies__c == 5){
                        makeRecord.Accepted_Policies__c = 5;
                    }else{
                      makeRecord.Accepted_Policies__c += 1;
                    }
                    if(makeRecord.Remaining_Policies__c == 0){
                        makeRecord.Remaining_Policies__c = 0;
                    }else{
                         makeRecord.Remaining_Policies__c -= 1;
                    }
                    collectAllRecord.add(makeRecord);
                    System.debug(collectAllRecord);
                }                
                update collectAllRecord;
                System.debug(collectAllRecord);
            } catch (DMLException e) {
                System.debug(e.getMessage());           
            }            
        }else{
            
            try {
                List<Employee_Regarding_Policy__c> collectAllRecord = new List<Employee_Regarding_Policy__c>();
                
                System.debug('listOfEmployee-->'+listOfEmployee);
                Employee_Regarding_Policy__c makeRecord = new Employee_Regarding_Policy__c();
                makeRecord.EmployeeName__c = listOfEmployee[0].Id;
                System.debug('makeRecord.EmployeeName__r.Id-->'+makeRecord.EmployeeName__c );
                makeRecord.Accepted_Policies__c = 1; // Assuming the first acceptance
                System.debug('makeRecord.Accepted_Policies__c-->'+makeRecord.Accepted_Policies__c);
                makeRecord.Remaining_Policies__c = 5; // Assuming there were initially 5 policies
                System.debug('makeRecord.Remaining_Policies__c-->'+makeRecord.Remaining_Policies__c);
                collectAllRecord.add(makeRecord);
                System.debug(collectAllRecord);
                
                
                insert collectAllRecord;
                System.debug(collectAllRecord);
            } catch (DMLException e) {
                System.debug(e.getMessage());           
            } 
            
        }
        
        
        
        
    }
}
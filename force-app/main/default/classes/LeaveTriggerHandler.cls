/*
@Name : LeaveTriggerHandler.apxc
@AuthorName : Ayush Patial
@Description : This class trigger on leave object when new leave is created

*/

public class LeaveTriggerHandler {
    
    /*
@Name : Ayush Patial
@Description : This method call on beforeInsert and auto populate the name of employee accrding to the current user email
@LastModified By : Ayush Patial
*/
    
    public static void onBeforeInsert(List<Leave__c> listOfLeaveRecord){
        
        
        
        
        // store current user email
        String currentUserEmail =  UserInfo.getUserEmail();
        
        // find useremail from user object
        User userEmail = [SELECT Email From User WHERE Email =:currentUserEmail limit 1];
        
        // find employee record on the basis of user email
        List<Employee__c> emailOfEmployee  = [SELECT Id,Email_Address__c From Employee__c Where Email_Address__c =: userEmail.Email limit 1];
        
        String nameOfEmployee = '';
        
        //store employee name
        for(Employee__c rec1 : emailOfEmployee){
            nameOfEmployee = rec1.Id;
        }
        
        //insert employee name on leave record
        for(Leave__c rec : listOfLeaveRecord){
            rec.Employee_Name__c = nameOfEmployee;
        }
        
        
    }
    
    /*
@Name : Ayush Patial
@Description : This method call on beforeInsert and auto populate the name of employee accrding to the current user email.
@LastModified By : Ayush Patial
*/
    
    public static void onAfterInsert(List<Leave__c> listOfLeaveRecord1, Map<Id,Leave__c> mapOfLeaveContact){
        
        //I create set for give current leave id to fetch leave
        /*Set<Id> setOfLeaveId = new Set<Id>();

for(Leave__c leaveRec : listOfLeaveRecord1){
if(!listOfLeaveRecord1.isEmpty()){
setOfLeaveId.add(leaveRec.Id);
}
} */
        
        
        //start       
        EmailTemplate temp = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'Approval_Status_is_Changed'];
        
        list<Messaging.SingleEmailMessage> mailListToSendEmail = new list<Messaging.SingleEmailMessage>();
        
        for(Leave__c leaveRecord : listOfLeaveRecord1){
            if(leaveRecord.Leave_Status__c  != mapOfLeaveContact.get(leaveRecord.Id).Leave_Status__c){
                Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(temp.Id, leaveRecord.OwnerId, leaveRecord.Id);
                mail.setSaveAsActivity(false);
                mailListToSendEmail.add(mail);
            }
            
        }
        
        Messaging.sendEmail(mailListToSendEmail);
        
        
        //end
        
        // String ccEmails = System.label.cc;
        List<String> sendCC = new List<String>();
        sendCC.addAll((System.label.cc).split(','));
        
        //String toEmails = System.label.To;
        List<String> sendTo = new List<String>();
        sendTo.addAll((System.label.To).split(','));
        
        
        list<Messaging.SingleEmailMessage> mailList = new list<Messaging.SingleEmailMessage>();
        
        EmailTemplate emailTemp = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'Email_Template_When_New_Leave_Is_Created'];
        //emailTemp.body.replace('{!Leave__c.Employee_Name__c}',listOfLeaveRecord1[0].Employee_Name__c);
        
        //This is i am doing to give data to emailtemplate relted to that leave
        // Leave__c leave = [SELECT Id,Employee__c FROM Leave__c WHERE Id IN :  setOfLeaveId ];
        
        Contact con = [SELECT Id FROM Contact WHERE Email = 'patialayush3@gmail.com' limit 1];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        //String[] toaddresses = new String[] {ccEmails}; 
        //String[] ccaddresses = new String[] {toEmails};
        
        mail.setToAddresses(sendTo);
        mail.setccAddresses(sendCC);
        mail.setTargetObjectId(con.Id);
        mail.setWhatId(listOfLeaveRecord1[0].Id);
        //mail.setToAddresses(toAddresses);
        // mail.setCcAddresses(ccAddresses);
        
        mail.setTemplateId(emailTemp.Id);
        mailList.add(mail);
        
        if(!mailList.isEmpty()){
            Messaging.sendEmail(mailList);
        }
     
    }
    
}
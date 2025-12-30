public with sharing class SendMonthlySlipOnEmail {
    //Store The Reference of MonthlySalaryPdf
    PageReference pageRef = new PageReference('/apex/MonthlySalaryPdf');
    
    private final   Id currentUserData;
    
    public SendMonthlySlipOnEmail(ApexPages.StandardController controller){
        
        // Fectch the current page record Id
        currentUserData = controller.getId();
        System.debug(currentUserData);
        pageRef.getParameters().put('id', currentUserData);	
    }
    
    public void sendEmail(){
        
        //Store the pageRef Data in blob
        blob  storePdfData = pageRef.getContentAsPdf();
        
        //Get The Monthly Salary Data From The Current Monthly Id
        Monthly_Salary__c dataOfMonthly = [SELECT Id, Employee_Name__c,Employee_Name__r.Email_Address__c, Month__c FROM Monthly_Salary__c WHERE Id =: currentUserData limit 1];
        System.debug(dataOfMonthly.Employee_Name__r.Email_Address__c);
        
        //Get Employee Address 
       Employee__c employeeEmail = [Select Id, Email_Address__c From Employee__c Where Id =: dataOfMonthly.Employee_Name__c];
        
        
        
        //Get EmailTemplate From This query
        EmailTemplate temp = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'Salary_Slip'];
        
        //Store EmailFileAttachment and Give the fileName and Also setBody
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('MonthlySalaryPdf.pdf');
        efa.setBody(storePdfData);
        
        
        list<Messaging.SingleEmailMessage> mailListToSendEmail = new list<Messaging.SingleEmailMessage>();
        
        
        
        
        Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(temp.Id, UserInfo.getUserId(), dataOfMonthly.Id);
        mail.setSaveAsActivity(false);
        mail.setToAddresses(new String[]  {employeeEmail.Email_Address__c});
        mail.setTreatTargetObjectAsRecipient(false);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        
        
        
        
        
        
        
        
        
    }   
    
    
    
}
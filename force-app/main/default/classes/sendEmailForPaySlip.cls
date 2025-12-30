public with sharing class sendEmailForPaySlip {
    
        public String subject { get; set; }
        public String body { get; set; }
    
        public final Monthly_Salary__c monthSalary;
    
        // Create a constructor that populates the MonthlySalary__c object
        public sendEmailForPaySlip() {
            monthSalary = [SELECT Id,Monthly_Salary__c.Employee_CTC__r.Name,Monthly_Salary__c.Employee_Name__r.Email_Address__c
                       FROM Monthly_Salary__c 
                       WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        }
    
        public Monthly_Salary__c getMonthlyData() {
            return monthSalary;
        }
    
        public PageReference send() {
            // Define the email
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
    
            // Reference the attachment page and pass in the account ID
            PageReference pdf =  Page.attachmentPDF;
            pdf.getParameters().put('id',(String)monthSalary.id); 
            pdf.setRedirect(true);
    
            // Take the PDF content
            Blob b = pdf.getContent();
    
            // Create the email attachment
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName('attachment.pdf');
            efa.setBody(b);
    
            String addresses;

            if (monthSalary.Employee_Name__r.Email_Address__c!= null) {
                addresses = monthSalary.Employee_Name__r.Email_Address__c;
                // Loop through the whole list of contacts and their emails
               // for (Integer i = 1; i < account.Contacts.size(); i++) {
                 //   if (account.Contacts[i].Email != null) {
                 //       addresses += ':' + account.Contacts[i].Email;
                  //  }
               // }
            }
            
    
            String[] toAddresses = addresses.split(':', 0);
    
            // Sets the paramaters of the email
            email.setSubject( subject );
            email.setToAddresses( toAddresses );
            email.setPlainTextBody( body );
    
            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
    
            // Sends the email
            Messaging.SendEmailResult [] r = 
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});   
            
            return null;
        }
    }
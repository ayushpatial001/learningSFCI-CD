/*
@Name : BirthdayNotifySchedulerClass.apxc
@Author : Ayush Patial
@Date : 6 Aug 2024
@Description : This is schedule class use to send an email to employee on their birthday
*/
public class BirthdayNotifySchedulerClass implements Schedulable{
    
    public void execute(SchedulableContext ex){
        Integer currentMonth = System.today().month();
        Integer currentDay = System.today().day();
        List<Employee__c>  listOfEmployee = [SELECT Id ,Name,Email_Address__c, Date_of_Birth__c  From Employee__c Where CALENDAR_MONTH(Date_of_Birth__c) =: currentMonth And DAY_IN_MONTH(Date_of_Birth__c) =: currentDay];
        Email_For_CC__mdt ccAddress = [Select Id, Email__c From Email_For_CC__mdt limit 1]; 
        
        list<Messaging.SingleEmailMessage> mailList = new list<Messaging.SingleEmailMessage>();
        
        EmailTemplate emailTemplate = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'BirhtdayEmail'];
        
        Contact contactRecord = [SELECT Id FROM Contact WHERE Email = 'patialayush3@gmail.com' limit 1];
       
        for(Employee__c empRecord : listOfEmployee){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {empRecord.Email_Address__c};
            mail.setToAddresses(toAddresses);
            mail.setccAddresses(new String[] {ccAddress.Email__c});
            mail.setTargetObjectId(contactRecord.Id); 
            mail.setTemplateId(emailTemplate.Id);
            mail.setWhatId(empRecord.Id); 
            mailList.add(mail);
        }
        
        
        
        if(!mailList.isEmpty()){
            Messaging.sendEmail(mailList);
        }
        
        
        
        
        
    }
    
}
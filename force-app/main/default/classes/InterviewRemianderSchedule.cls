/*
 @Name: InterviewRemianderSchedule.apxc
 @Author : Ayush Patial
 @Date : 6 Aug 2024
 @Description : This schdeule class use to send email to candidate when his interview is tomorrow.so it work as a reminder to that candidate .
*/
public class InterviewRemianderSchedule implements Schedulable{
    
    public void execute(SchedulableContext ex){
        
        //Create a Schedulable Class to send an email to the candidate that notify that your interview is tomorrow. so please join on time. 
        //and schedule this class on daily basis.
        
        Date tommorrow = System.today().addDays(1);
        
        List<Interview__c> listOfInterview = [Select Id,Candidate__c,Interview_Date_Time__c,Interview_Status__c From Interview__c Where  Interview_Status__c ='Scheduled'];
        
        Set<Id> listOfCandidateId = new set<Id>();
        
        for(Interview__c acc : listOfInterview){
            Date interviewDate = acc.Interview_Date_Time__c.date();
            System.debug(interviewDate);
            if(interviewDate == tommorrow){
                listOfCandidateId.add(acc.Candidate__c); 
            }
        }
        System.debug(listOfCandidateId);
        
        
        
        List<Candidate__c> listOfCandidate =  [Select Id, Candidate_Email_id__c From Candidate__c Where Id In : listOfCandidateId];
        System.debug(listOfCandidate);
        
        
        list<Messaging.SingleEmailMessage> mailList = new list<Messaging.SingleEmailMessage>();
        
        EmailTemplate emailTemplate = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'Interview_Reminder'];
        
        Contact contactRecord = [SELECT Id FROM Contact WHERE Email = 'patialayush3@gmail.com' limit 1];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        for(Candidate__c candidateRecord : listOfCandidate){
                String[] toAddresses = new String[] {candidateRecord.Candidate_Email_id__c};
                mail.setToAddresses(toAddresses); 
                mail.setTargetObjectId(contactRecord.Id); 
                mail.setTemplateId(emailTemplate.Id);
                mail.setWhatId(candidateRecord.Id); 
                mailList.add(mail);
            }
            
           
        if(!mailList.isEmpty()){
            Messaging.sendEmail(mailList);
        }  
            
            
            
            
            
        }
        
        
    }
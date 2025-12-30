/*
@Name : InterviewTriggerHandler.apxc
@AuthorName : Ayush Patial
@Description : This class is used to send email when a new interview is scheduled
@Created Date : 1 Aug 2024


*/

public class InterviewTriggerHandler {
    
    /*
@Name: Ayush Patial
@Created By : Ayush Patial
@LastModified On : 2 Aug 2024
*/
    
    public static void onAfter(List<Interview__c> listOfInterview){
        Set<Id> setOfCandidateId = new Set<Id>();
        Set<Id> setOfInterviewerId = new Set<Id>();
        
        
        // store candidate and interviewer id 
        if(!listOfInterview.isEmpty()){
            for(Interview__c intRecord : listOfInterview){   
                setOfCandidateId.add(intRecord.Candidate__c);
                setOfInterviewerId.add(intRecord.Interviewer_Name__c);
            }
        }
        
        
        List<Employee__c> listOfInterviewerEmail = [SELECT Email_Address__c FROM Employee__c WHERE Id IN : setOfInterviewerId];
        
        List<Candidate__c> listOfCandidateEmail = [SELECT Candidate_Email_id__c FROM Candidate__c WHERE Id IN : setOfCandidateId];
        
        List<String> listOfEmails = new List<String>();
        
        
        for(Employee__c recordOfInterveiwer : listOfInterviewerEmail){
            listOfEmails.add(recordOfInterveiwer.Email_Address__c);
        }
        
        for(Candidate__c recordOfCandidate : listOfCandidateEmail){
            listOfEmails.add(recordOfCandidate.Candidate_Email_id__c);
        }
        
        System.debug(listOfEmails);
        
        
        List<String> hrEmail = new List<String>();
        hrEmail.addAll((System.label.cc).split(','));
        
        
        
        list<Messaging.SingleEmailMessage> mailList = new list <Messaging.SingleEmailMessage>();
        for(Interview__c record : listOfInterview){
            if(record.Interview_Status__c == 'Scheduled'){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setSubject('⚠️ Interview Scheduled On' + record.Interview_Date_Time__c );
                String body = 'Dear Candidate. \n\n' +
                    'I hope this message finds you well.\n\n' +
                    'Thank you for your interest. We are pleased to inform you that we have scheduled an interview for you to discuss this exciting opportunity further.\n\n' +
                    'Here are the details of your interview:\n\n' +
                    '- DateTime: ' + record.Interview_Date_Time__c + '\n' +
                    '- InterviewStatus: ' + record.Interview_Status__c + '\n' +
                    '- InterviewType: ' + record.Interview_Type__c + '\n\n' +
                    'Please confirm your availability for the scheduled time by replying to this email. If you need to reschedule or have any questions before the interview, feel free to let us know.\n\n' ;
                
                
                
                // Set the body
                mail.setPlainTextBody(body);
                mail.setToAddresses(listOfEmails);
                mail.setccAddresses(hrEmail);
                mailList.add(mail);
                
            }
            
        }
        
        
        //check if mail list empty or not
        if(!mailList.isEmpty()){
            Messaging.sendEmail(mailList);
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
}
public class TaskRelatedToCase {
    
    @AuraEnabled
    public static List<wrapperClass> fetchTask(){
        
        List<wrapperClass>  listWrapper = new List<wrapperClass>();
        
        List<Task> fetchTaskRelatedToCase = [SELECT Id, Subject, ActivityDate, What.Name ,WhatId, OwnerId, Owner.Name 
                                             FROM Task 
                                             WHERE WhatId IN (SELECT Id FROM Case)];
        
        
        Set<Id> caseIds = new Set<Id>();
        for (Task taskRecord : fetchTaskRelatedToCase) {
            caseIds.add(taskRecord.WhatId);
        }

        
        Map<Id, Case> caseMap = new Map<Id, Case>([SELECT Contact.Name ,Id, AccountId, Subject, Status FROM Case WHERE Id IN :caseIds]);

        
        for (Task taskRecord : fetchTaskRelatedToCase) {
            Case caseRecord = caseMap.get(taskRecord.WhatId);
            if (caseRecord != null) {
                listWrapper.add(new wrapperClass(caseRecord.Id, caseRecord.Subject, caseRecord.Status, caseRecord.Contact.Name ,taskRecord.Subject, taskRecord.ActivityDate));
            }
        }

      
        for (wrapperClass wc : listWrapper) {
            System.debug('Wrapper: ' + JSON.serializePretty(wc));
        }
        return listWrapper;
    }

    
        
        
        
    
    
    
    public class wrapperClass{
        @AuraEnabled
        public Id CaseId{get; set;}
        @AuraEnabled
        public String Subject{get;set;}
        @AuraEnabled
        public String Status{get;set;}
        @AuraEnabled
        public String ContactName{get; set;}
        @AuraEnabled
        public String taskSubject{get;set;}
        @AuraEnabled
        public Date ActivityDate{get;set;}
        
        
        public wrapperClass(Id caseId, String Subject, String Status, String ContactName,String taskSubject, Date ActivityDate){
            this.caseId = caseId;
            this.Subject = Subject;
            this.Status = Status;
            this.taskSubject = taskSubject;
            this.ActivityDate = ActivityDate;
            this.ContactName = ContactName;
        }
    }
    
}
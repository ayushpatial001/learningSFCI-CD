public with sharing class CreateMultipleRecordsForEmployee {
    public List<Employee__c> empRecord{get;set;}
    
    
    
    public CreateMultipleRecordsForEmployee(){
       
        empRecord = new List<Employee__c>();
        Employee__c makeRecord = new Employee__c();
        empRecord.add(makeRecord);
    }

    public void addRecord(){
        Employee__c makeRecord = new Employee__c();
        empRecord.add(makeRecord);
    }
    
    public void deleteRecord(){
         Employee__c makeRecord = new Employee__c();
        if(empRecord.size()>1){
          
            empRecord.remove(empRecord.size()-1);
        }
        
    }

    public PageReference saveAccount(){
       try{
        insert empRecord;
       }catch(DmlException e){
        System.debug(e.getMessage());
       }
       return null;
    }

}
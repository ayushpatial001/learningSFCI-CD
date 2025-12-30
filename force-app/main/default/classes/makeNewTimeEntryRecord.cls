public with sharing class makeNewTimeEntryRecord {
    
    @AuraEnabled
    public static void makeData(){
        List<Employee__c> listofEmployee = [Select Id , Name ,Email_Address__c From Employee__c where Email_Address__c =: UserInfo.getUserEmail() limit 1];
        DateTime currentdatetime = DateTime.now();
        Time_Entry__c makeNewTime = new Time_Entry__c();
        makeNewTime.Employee_Name__c = listofEmployee[0].Id;
        makeNewTime.In_Time__c = currentdatetime;
        try{
            insert makeNewTime;
        }catch(DmlException e){
           System.debug(e.getmessage());
        }
    }

    @AuraEnabled
    public static void updateData(){
        List<Employee__c> listofEmployee = [Select Id , Name ,Email_Address__c From Employee__c where Email_Address__c =: UserInfo.getUserEmail() limit 1];
        DateTime currentdatetime = DateTime.now();
        Date getdate = currentdatetime.date();
        Time_Entry__c makeNewTime = new Time_Entry__c();
        List<Time_Entry__c>  gettodayData = [Select Id,Employee_Name__c, In_Time__c,Out_Time__c, Status__c From Time_Entry__c Where Employee_Name__c =: listofEmployee[0].Id  And CreatedDate = TODAY limit 1];
        if(gettodayData.size() > 0 ){
            makeNewTime.Id = gettodayData[0].Id;
            makeNewTime.Employee_Name__c = listofEmployee[0].Id;
            makeNewTime.Out_Time__c = currentdatetime;
        }    
        
        try{
            update makeNewTime;
            System.debug(gettodayData);
        }catch(DmlException e){
            System.debug(e.getMessage());
        }

    }
    @AuraEnabled
    public static Boolean checkTodayHasData(){
        List<Employee__c> listofEmployee = [Select Id , Name ,Email_Address__c From Employee__c where Email_Address__c =: UserInfo.getUserEmail() limit 1];
        DateTime currentdatetime = DateTime.now();
        Date getdate = currentdatetime.date();
        Time_Entry__c makeNewTime = new Time_Entry__c();
        List<Time_Entry__c>  gettodayData = [Select Id,Employee_Name__c, In_Time__c,Out_Time__c, Status__c From Time_Entry__c Where Employee_Name__c =: listofEmployee[0].Id  And CreatedDate = TODAY limit 1];
        if(gettodayData.size() > 0 ){
            return true;
        }else{
            return false;
        }

    }

    
        
        
        

    
   

}
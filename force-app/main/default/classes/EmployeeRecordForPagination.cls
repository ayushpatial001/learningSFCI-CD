public with sharing class EmployeeRecordForPagination {
    @AuraEnabled
    public static Integer totalRecords(){
        return [Select COUNT() From Employee__c];
    }

    @AuraEnabled(cacheable=true)
    public static List<Employee__c> getEmployeeList(Integer v_Offset, Integer v_pagesize){
        return [Select Id,Email_Address__c,Name,Primary_Number__c,Joining_Date__c FROM Employee__c LIMIT  :v_pagesize OFFSET :v_Offset];
    }

    @AuraEnabled
    public static Integer getNext(Integer v_Offset, Integer v_pagesize){
        v_Offset += v_pagesize;
        return v_Offset;
    }

    @AuraEnabled(cacheable=true)
    public static Integer getPrevious(Integer v_Offset, Integer v_pagesize){
        v_Offset -= v_pagesize;
        return v_Offset;
    }

    @AuraEnabled
    public static List<Employee__c> listOfSeachableRecord(String searchKey){
        List<Employee__c> listOfEmployee = new List<Employee__c>()  ;
            if(searchKey != ' ' && searchKey != null){
                String searchParserKey = '%' + searchKey + '%';
                listOfEmployee =  [Select Id,Email_Address__c,Name,Primary_Number__c,Joining_Date__c FROM Employee__c WHERE Name LIKE : searchParserKey];
            }
            return listOfEmployee;
    }
    
}
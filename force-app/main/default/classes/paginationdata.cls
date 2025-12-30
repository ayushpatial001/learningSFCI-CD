public with sharing class paginationdata {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getEmployees(Integer pageSize, Integer pageNumber) {
        List<Employee__c> employees = [SELECT Id, Name, Gender__c
                                       FROM Employee__c
                                       ORDER BY CreatedDate DESC
                                       LIMIT :pageSize
                                       OFFSET :((pageNumber - 1) * pageSize)];

        Integer totalEmployees = [SELECT Count() FROM Employee__c];

        Map<String, Object> result = new Map<String, Object>();
        result.put('records', employees);
        result.put('total', totalEmployees);
        return result;
    }

    @AuraEnabled
    public static void updateEmployee(List<Employee__c> data) {
        update data;
    }

    @AuraEnabled
    public static void deleteEmployee(Id employeeId) {
        Employee__c emp = [SELECT Id FROM Employee__c WHERE Id = :employeeId LIMIT 1];
        delete emp;
    }
}
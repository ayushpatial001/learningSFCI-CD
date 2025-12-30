public with sharing class FetchLeaveDataAccToCurrentLoginData {
     
    public class wrapperClass{
        @AuraEnabled
       public Decimal RemainigLeaves;
        @AuraEnabled
       public Decimal TotalBalance;
       
        wrapperClass(Decimal RemainigLeaves, Decimal TotalBalance){
             this.RemainigLeaves = RemainigLeaves;
             this.TotalBalance = TotalBalance;
        }

    }

    @AuraEnabled
    public static List<wrapperClass> getRemainingLeaves(){
        List<wrapperClass> wrapList = new List<wrapperClass>();
        Employee__c currentEmployee = [Select Id ,Email_Address__c From Employee__c WHere Email_Address__c =: UserInfo.getUserEmail() limit 1];
        for(Leave__c getR : [SELECT Id, Available_Balance__c, Total_Balance__c , Employee_Name__c FROM Leave__c WHere Employee_Name__c =: currentEmployee.Id ORDER BY CreatedDate LIMIT 1]){
            wrapList.add(new wrapperClass(getR.Available_Balance__c,getR.Total_Balance__c));
        } 

        return wrapList;
    }
}
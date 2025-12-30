/*
@Name: Ayush Patial
@Author: Ayush Patial
@Description:This Class Used For Leave Object To Count No Of Leave Balance Per Employee
@CreatedDate: 07/01/2024
@LastModifiedDate: 19 July 2024

*/

public class EmployeeLeaveBalance {
    
    /*
@Author : Ayush Patial
@Description : leaveBalanceOfEmployee use To fetch Leave Record data
*/
    public static void leaveBalanceOfEmployee(){
        
        // listOfLeaveBalance fetch Leave Record Where Employee is active
        try{
            List<Leave__c> listOfLeaveBalance = [SELECT Id, Employee_Name__r.Name, Available_Balance__c FROM Leave__c WHERE Employee_Name__r.Active__c = TRUE ];   
            for(Integer i=0;i<listOfLeaveBalance.size();i++){
                System.debug(listOfLeaveBalance[i].Employee_Name__r.Name +':'+ listOfLeaveBalance[i].Available_Balance__c);
            }
        }
        catch(Exception ex){
            System.debug('Exception at line'+ ex.getlinenumber()+ 'msg'+ ex.getmessage());
        }
        
        // listForTotalOpportunity fetch to sum of all the opportunity ammout associates with the particular account.
        Decimal countTotalAmount = 0;
        List<Account> listOfTotalSumOfOpportunities = [select ID, Name,(Select Amount from Opportunities ) From Account WHERE ID = '001dM00000ElBxdQAF'];
       // System.debug(listOfTotalSumOfOpportunities);
        
        
        for(Account acc: listOfTotalSumOfOpportunities){
           // List<Opportunity> totalamount = acc.am;
            System.Debug('acc -->'+acc);
            
            List<Opportunity> listOfOpp = acc.Opportunities;
            for(Opportunity opp : listOfOpp){
                if(opp.amount != Null){
                       countTotalAmount += opp.amount;
                }
             
        }
           System.debug(countTotalAmount);
        }
        

        
        
        
        
    }
    
    
}
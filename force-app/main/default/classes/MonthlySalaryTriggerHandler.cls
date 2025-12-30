/*
@Name : MonthlySalaryTriggerHandler.apxc
@AuthorName : Ayush Patial
@Description : This class is used to perform action when new monthly salary is created
@Created Date : 1 Aug 2024


*/

public class MonthlySalaryTriggerHandler {
    
/*
@Name : Ayush Patial
@LastModified on : 1 Aug 2024
@Description : This method call when user fill employee name on monthly salaries and automatic his employeectc fetch and calculate the all other values
*/
 
    public static void onBefore(List<Monthly_Salary__c> listOfMonthlySalary){
        // Fetch EmployeeId with respect to that monthly salary account
        if(!listOfMonthlySalary.isEmpty()){
            // store Employee ID 
            Set<Id> setOfEmployeeId = new Set<Id>();
            
            for(Monthly_Salary__c rec : listOfMonthlySalary){
                setOfEmployeeId.add(rec.Employee_Name__c);
            }
            //Then we fetch EmployeeCTC with  respect to that Employee Id
            List<Employee_CTC__c> listOfEmployeeCTC = [Select Id, Employee_Name__c From Employee_CTC__c WHERE Employee_Name__c IN : setOfEmployeeId];
            
            System.debug(listOfEmployeeCTC);
            
            Map<Id ,Employee_CTC__c> mapOfEmployeeIdWithEmployeeCTC = new Map<Id, Employee_CTC__c>();
            
            
            for(Employee_CTC__c recordOfCTC : listOfEmployeeCTC){
                
                mapOfEmployeeIdWithEmployeeCTC.put(recordOfCTC.Employee_Name__c, recordOfCTC);
            }
            
            
            //Then Put the value Of EmployeeCTC on Monthly Salary
            
           /* for(Monthly_Salary__c monthlySalary : listOfMonthlySalary){
                try{
                      monthlySalary.Employee_CTC__c = mapOfEmployeeIdWithEmployeeCTC.get(monthlySalary.Employee_Name__c).Id;
                }catch(NullPointerException e){
                    System.debug(e.getmessage());
                    monthlySalary.addError('This employee has no CTC Please Make EmployeeCTC Record first');
                }
              
                
            }*/
        }

        
    }
    
}
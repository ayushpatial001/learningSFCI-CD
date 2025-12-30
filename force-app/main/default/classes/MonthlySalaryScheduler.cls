public class MonthlySalaryScheduler implements Schedulable{
    
    public void execute(SchedulableContext cx){
        
        String cureentMonth = Datetime.now().format('MMM-yyyy').toUpperCase();
        
        List<Employee__c> listOfEmployee = [Select Id From Employee__c Where Active__c = True ];
        
        List<Monthly_Salary__c>  listOfMonthlySalary = new List<Monthly_Salary__c>();
        
        
       
            for(Employee__c recordEmployee : listOfEmployee){
                Monthly_Salary__c makeReocd = new Monthly_Salary__c();
                makeReocd.Employee_Name__c = recordEmployee.Id;
                makeReocd.Salary_Month_Name__c = cureentMonth;
                listOfMonthlySalary.add(makeReocd);
            }
            
        
        
        try{
            insert listOfMonthlySalary;
        }catch(DMLException e){
            System.debug(e.getmessage());
        }
        
        
        
        
        
        
    }
}
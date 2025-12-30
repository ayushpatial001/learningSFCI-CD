/*
@Name : GenerateEmployeeCode.apxt
@Author : Ayush Patial
@Description : This trigger set Employee__code automatically when new employee record is inserting
*/
//Naming COnvention : EmployeeTrigger.
trigger GenerateEmployeeCode on Employee__c (before insert ) {
    
    //List<Employee__c> listOfEmployee = new List<Employee__c>();
    Employee__c empObj = new Employee__c();
    
    // fetch latest Employee__c code on the basis of createdate
    try{
        
        empObj=[SELECT id,Employee_Code__c ,CreatedDate from Employee__c order by CreatedDate desc limit 1];
        
        Integer autoNumber;
       // capture the number of last string of employee__code to increase that  
        if(empObj!=NULL){
            autoNumber=Integer.valueOf(empObj.Employee_Code__c.substring(9));
        }else{
            autoNumber=0;
        }
            // insert Employee__code in new record
        for(Employee__c emp : trigger.new){
            
            autoNumber++;
            emp.Employee_Code__c='TMC-'+System.today().year()+'-'+String.valueOf(autoNumber);
            
        }   
        
        
    }catch(Exception e){
        
        System.debug(e.getMessage());
        
    }
   
    
    
    

    
    
    
}
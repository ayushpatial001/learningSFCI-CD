@isTest
public class DataFactory {
    
    public static Employee__c makeEmployeeRecord(String name, String email, String phoneNumber) {
        Employee__c newEmployee = new Employee__c();
        newEmployee.Name = name;
        newEmployee.Joining_Date__c = System.today().addDays(-50);
        newEmployee.Date_of_Birth__c = Date.newInstance(2002,8,7);
        newEmployee.Email_Address__c = email;
        newEmployee.Primary_Number__c = phoneNumber;
        //newEmployee.Employee_Code__c = employeeCode;
        return newEmployee;
    }
    
    public static Leave__c makeLeaveRecord(String employeeId, String leaveReason, String leaveStatus) {
        Leave__c newLeaveRecord = new Leave__c();
        newLeaveRecord.Employee_Name__c = employeeId; 
        newLeaveRecord.Leave_Reason__c = leaveReason;
        newLeaveRecord.Leave_Status__c = leaveStatus;
        newLeaveRecord.Leave_Type__c = 'CL';
        return newLeaveRecord;
    }
    
    
    public static User createUser(String profile, String alias, String email, String lastName,String userName){
        Profile p = [SELECT Id FROM Profile WHERE Name=: profile]; 
        User u = new User(Alias = alias, 
        Email= email, 
        EmailEncodingKey='UTF-8', 
        LastName= lastName, 
        LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', 
        ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', 
        UserName= userName);
        return u;
    }
    
    
    public static Project__c makeProject(String employeeId, String userId, String projectName) {
        Project__c proj = new Project__c();
        proj.Employee_Name__c = employeeId; 
        proj.Name = projectName;
        proj.Project_Manager__c = userId; 
        proj.Project_Start_Date__c = System.today();
        proj.Project_End_Date__c = System.today().addDays(20);
        return proj;
    }
    
    public static Timesheet__c makeTimesheet(String employeeId, String projectId, String description) {
        Timesheet__c timesheetRecord = new Timesheet__c();
        timesheetRecord.Employee_Name__c = employeeId; 
        timesheetRecord.Project__c = projectId; 
        timesheetRecord.Start_Project_Date__c = DateTime.newInstance(2024, 7, 11, 4, 12, 30);
        timesheetRecord.End_Project_Date__c = DateTime.newInstance(2024, 7, 11, 6, 10, 30);
        timesheetRecord.Description__c = description;
        return timesheetRecord;
    }
    
    public static Account createAccount(String accountName , Boolean createContactCheckbox, String accountNumber){
        Account account = new Account();
        account.Name = accountName;
        account.Email__c = 'patialayush3@gmail.com';
        account.AccountNumber = accountNumber;
      //  account.Active__c = 'No';
        account.Create_Contact__c = createContactCheckbox;
        account.Phone = '9812345678';
        account.BillingCity = 'asds';
      //  account.OwnerId = ownerId;
        return account;
    }
    
    public static Employee_CTC__c createRecord(String empId, boolean employeeEPF, boolean employerEPF, boolean employeeESIC,Decimal basicsalary, Decimal grossSalary){
        
         Employee_CTC__c recordCTC = new Employee_CTC__c();
         recordCTC.Employee_Name__c = empId;
         recordCTC.Current_CTC__c = 2222222.0;
         recordCTC.Basic_Salary__c = basicsalary;
         recordCTC.Employee_EPF__c  = employeeEPF;
         recordCTC.Employer_EPF__c = employerEPF ; 
         recordCTC.ESIC__c = employeeESIC;
         recordCTC.Gross_Salary__c = grossSalary;
        
         return  recordCTC;
        
    }
    
    public static Monthly_Salary__c createMonthlySalary(String employeeId, String employeeCTCId){
        
        Monthly_Salary__c  recordOfMonthly = new Monthly_Salary__c();
        recordOfMonthly.Employee_Name__c = employeeId;
        recordOfMonthly.Employee_CTC__c = employeeCTCId;
        recordOfMonthly.Salary_Month_Name__c = Datetime.now().format('MMM-yyyy').toUpperCase();
        
        return recordOfMonthly;
    }
    
    public static Candidate__c  createCandidateRecord(String name, String email){
        Candidate__c makeRecord = new Candidate__c();
        makeRecord.Name = name;
        makeRecord.Candidate_Email_id__c = email;
        return makeRecord;
        
    }
    
    public static Interview__c createInterview(String employeeId, String candidateId , String status){
        
        Interview__c recordOfInterview = new Interview__c();
        recordOfInterview.Google_Meeting_link__c = 'adasd.com';
        recordOfInterview.Interviewer_Name__c = employeeId;
        recordOfInterview.Candidate__c = candidateId;
        recordOfInterview.Interview_Status__c = status;
        recordOfInterview.Interview_Type__c = 'Virtual';
        recordOfInterview.Interview_Date_Time__c = System.today().addDays(1);
        
        return recordOfInterview;
    }
    
    public static Opportunity createOpportunityRecord(String accountId, String oppName, String email){
        Opportunity oppRecord = new Opportunity();
        oppRecord.AccountId = accountId;
        oppRecord.Name = oppName;
        oppRecord.CloseDate = System.today().addDays(-30);
        oppRecord.StageName = 'Prospecting';
        oppRecord.Email__c = email;
        
        return oppRecord;
    }
    
    public static Contact createContact(String accountId, String lastName, string email, String description){
        Contact conRecord = new Contact();
        conRecord.AccountId = accountId;
        conRecord.LastName = lastName;
        conRecord.email = email;
        conRecord.Description = description;
        
        return conRecord;
            
        
    }
    
    public static Policies_and_Guidelines__c createNewPolicy(String policyName, String description, Decimal version, String acknowledged){
        Policies_and_Guidelines__c newPolicy = new Policies_and_Guidelines__c();
        newPolicy.Policy_Name__c = policyName;
        newPolicy.Description__c = description;
        newPolicy.Version__c = version;
        newPolicy.Acknowledged__c = acknowledged;
        
        return newPolicy;
       
            
        
    }
    
}
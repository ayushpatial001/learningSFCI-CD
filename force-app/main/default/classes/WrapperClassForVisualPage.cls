public with sharing class WrapperClassForVisualPage {
    
    public static List<wrapper> getWrapperString() {
        List<wrapper> collectAllData = new List<wrapper>();
        
        
        List<Employee__c> listOfEmployee = [SELECT Id, Employee_Code__c, Name, Email_Address__c, Primary_Number__c
                                            FROM Employee__c
                                            WHERE Active__c = TRUE];
        
        
        List<Leave__c> listOfLeave = [SELECT Id, Employee_Name__c, Total_Leaves__c, Available_Balance__c
                                      FROM Leave__c
                                      WHERE Employee_Name__c IN :listOfEmployee];
        
        List<Project__c> listOfProject = [SELECT Id, Employee_Name__c
                                          FROM Project__c
                                          WHERE Employee_Name__c IN :listOfEmployee];
        
        List<Timesheet__c> listOfTimesheet = [SELECT Id, Total_Hours__c, Employee_Name__c
                                              FROM Timesheet__c
                                              WHERE Employee_Name__c IN :listOfEmployee];
        
        // Create maps for quick lookup and aggregation
        Map<Id, Decimal> totalHoursMap = new Map<Id, Decimal>();
        
        Map<Id, Decimal> totalLeavesMap = new Map<Id, Decimal>();
        
        Map<Id, Decimal> remainingLeavesMap = new Map<Id, Decimal>();
        
        Map<Id, Integer> projectCountMap = new Map<Id, Integer>();
        
        // Calculate The total hours of timesheet object
        for (Timesheet__c timesheet : listOfTimesheet) {
            if (!totalHoursMap.containsKey(timesheet.Employee_Name__c)) {
                totalHoursMap.put(timesheet.Employee_Name__c, 0);
            }
            totalHoursMap.put(timesheet.Employee_Name__c, totalHoursMap.get(timesheet.Employee_Name__c) + timesheet.Total_Hours__c);
        }
        
        // Fetch total leaves and remaining leaves From Leaves Object
        for (Leave__c leave : listOfLeave) {
            totalLeavesMap.put(leave.Employee_Name__c, leave.Total_Leaves__c);
            remainingLeavesMap.put(leave.Employee_Name__c, leave.Available_Balance__c);
        }
        
        // Count projects Related To particular employee
        for (Project__c project : listOfProject) {
            if (!projectCountMap.containsKey(project.Employee_Name__c)) {
                projectCountMap.put(project.Employee_Name__c, 0);
            }
            projectCountMap.put(project.Employee_Name__c, projectCountMap.get(project.Employee_Name__c) + 1);
        }
        
       
        for (Employee__c emp : listOfEmployee) {
            Decimal totalHours = totalHoursMap.containsKey(emp.Id) ? totalHoursMap.get(emp.Id) : 0;
            Decimal totalLeave = totalLeavesMap.containsKey(emp.Id) ? totalLeavesMap.get(emp.Id) : 0;
            Decimal remainingLeaves = remainingLeavesMap.containsKey(emp.Id) ? remainingLeavesMap.get(emp.Id) : 0;
            Integer noOfProjects = projectCountMap.containsKey(emp.Id) ? projectCountMap.get(emp.Id) : 0;
            
            collectAllData.add(new wrapper(
                emp.Employee_Code__c,
                emp.Name,
                emp.Email_Address__c,
                emp.Primary_Number__c,
                totalLeave,
                remainingLeaves,
                noOfProjects,
                totalHours
            ));
        }
        
        return collectAllData;
    }
    
    public class wrapper {
        public String empCode { get; set; }
        public String empName { get; set; }
        public String empEmail { get; set; }
        public String empPhone { get; set; }
        public Decimal totalLeave { get; set; }
        public Decimal remainingLeaves { get; set; }
        public Integer NoOfProject { get; set; }
        public Decimal TotalTimesheetHour { get; set; }
        
        public wrapper(String empCode, String empName, String empEmail, String empPhone,
                       Decimal totalLeave, Decimal remainingLeaves, Integer NoOfProject,
                       Decimal TotalTimesheetHour) {
                           this.empCode = empCode;
                           this.empName = empName;
                           this.empEmail = empEmail;
                           this.empPhone = empPhone;
                           this.totalLeave = totalLeave;
                           this.remainingLeaves = remainingLeaves;
                           this.NoOfProject = NoOfProject;
                           this.TotalTimesheetHour = TotalTimesheetHour;
                       }
    }
}
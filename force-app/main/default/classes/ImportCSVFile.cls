public class  ImportCSVFile{
    
    public String Filename{get;set;}
    public Blob FileContent{get;set;}
    String[] filelines = new String[]{};
    Set<String> setOfEmployeeName = new Set<String>();
    List<Time_Entry__c> timeEntryUpload = new List<Time_Entry__c>();
    
    public ImportCSVFile(ApexPages.StandardController controller){
        
    }
    
    public PageReference ReadFile(){
        Filename = FileContent.toString();
        filelines = Filename.split('\n');
        System.debug('filelines-->'+ filelines);
        for(Integer i=0;i<filelines.size();i++){
            String[] values = new String[]{};
            values = filelines[i].split(',');
            setOfEmployeeName.add(values[0]);
        }
        System.debug('setOfEmployeeName--->'+setOfEmployeeName);
        Map<String, Id> mapOfEmployeeIdAndString = new Map<String,Id>();
        for(Employee__c empRecord : [Select Id,Name From Employee__c Where Name IN  :setOfEmployeeName]){
            mapOfEmployeeIdAndString.put(empRecord.Name, empRecord.Id);
        }
        System.debug('mapOfEmployeeIdAndString--->'+ mapOfEmployeeIdAndString);
        //Now Store Excel Sheet Data 
        for(Integer i = 1;i<filelines.size();i++){
            System.debug(filelines[i]);
            String[] splitData = filelines[i].split(',');
            System.debug('splitData-->'+splitData[i]);
            String[] inputTime = splitData[2].split(',');
            String firstInputTime = inputTime[0].remove('"');
            DateTime dateTimeString = DateTime.valueOf(splitData[1] + ' ' + firstInputTime);
            String inTime = dateTimeString.format('yyyy-MM-dd\' \'HH:mm:ss');
            DateTime dateTimeOut = DateTime.valueOf(splitData[1] + ' ' + splitData[3]);
            String outTime = dateTimeOut.format('yyyy-MM-dd\' \'HH:mm:ss');
            Time_Entry__c makeRecord = new Time_Entry__c();
            makeRecord.Employee_Name__c = mapOfEmployeeIdAndString.get(splitData[0]);
            makeRecord.In_Time__c = DateTime.valueOf(inTime);
            makeRecord.Out_Time__c = DateTime.valueOf(outTime);
             
            timeEntryUpload.add(makeRecord);
        }
        try{
            insert timeEntryUpload;
        }catch(DMLException e){
            System.debug(e.getmessage());
        }
        return null;
    }
}
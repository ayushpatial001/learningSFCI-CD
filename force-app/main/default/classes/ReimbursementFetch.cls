public with sharing class ReimbursementFetch {
    public static void fetchReimbRecords(){
        Map<String, List<Reimbursement__c>> mapOfReimbRecords = new Map<String, List<Reimbursement__c>>();
        List<Reimbursement__c>  listOfReimb = [SELECT Id ,Employee_Name__c, Name , From_Date__c, To_Date__c, Type__c FROM Reimbursement__c WHERE  Status__c = 'Pending'];
        System.debug(listOfReimb.size());
        System.debug(listOfReimb);
        // Map<Id, List<Reimbursement__c>> mapOfReimbRecordBySimply = new Map<String, List<Reimbursement__c>>(listOfReimb);
        //Sytem.debug(mapOfReimbRecordBySimply);
        try{
            for(Reimbursement__c records : listOfReimb){
                if(mapOfReimbRecords.containsKey(records.Employee_Name__c)){
                    
                    mapOfReimbRecords.get(records.Employee_Name__c).add(records);
                    
                }else{    
                    mapOfReimbRecords.put(records.Employee_Name__c, new List<Reimbursement__c>{records});
                    
                    
                    
                }
                
                
            }
            
        }catch(NullPointerException e){
            System.debug('this is happennig');
        }
        
        
        for(String key : mapOfReimbRecords.keySet()){
            System.debug(Key);
            System.debug(mapOfReimbRecords.get(Key));
        }
       // System.debug('If EmployeeId is not Contain -->' + mapOfReimbRecords );
        
        //System.debug(mapOfReimbRecords.size());
        
        System.debug('Trinee -->' + mapOfReimbRecords.get('a00dM00000CRagtQAD') );
    }
    
}
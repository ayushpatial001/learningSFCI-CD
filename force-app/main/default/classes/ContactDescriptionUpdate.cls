/*
 * 
 @Name: ContactDescriptionUpdate.apxc
 @Author Name : Ayush Patial
 @Description : This is Batchable class used to update description of contact object when his accountis active.
 @Created On : 1 August 2024

*/


public class ContactDescriptionUpdate implements Database.Batchable<sObject> {
    
   
   public Database.QueryLocator start(Database.BatchableContext BC){
       
        //use dynamic SOQL to get the records to update
        
        return Database.getQueryLocator('Select Id,	Description FROM Contact Where Account.Active__c != \'Yes\'');
    
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> listOfContact){

        for(Contact contactObj : listOfContact){
            
            contactObj.Description = 'Belongs to inactive account';
      
        }
        
        try{
            //update listOfContact;
          List<Database.SaveResult> saveResults = Database.update(listOfContact, false);
            System.debug(listOfContact);

            for (Database.SaveResult saveResult : saveResults) {
                if(saveResult.isSuccess()){
                    System.debug('Succesfully updated contact description');
                }else{
                    for(Database.Error err : saveResult.getErrors()){
                       System.debug(err.getStatusCode() + ':' + err.getmessage());
                    
                }
            }
        }
            
        }catch(DMLException e){
           System.debug(e.getmessage());
        }
        
    }
    
    
     public void finish(Database.BatchableContext BC){
        //optional add code to handle the finish of the batch job
        
    }
    

}
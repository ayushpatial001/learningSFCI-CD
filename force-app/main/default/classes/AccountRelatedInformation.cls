/*
@Name: Ayush Patial
@Author: Ayush Patial
@Description: This class is using Wrapper class to perform data binding.
@Date: 25 July 2024

*/



public  class AccountRelatedInformation {
    
    // wrapper class to bind different types of data
    public class WrapperClass{
        public String accountName = '';
        public List<Contact> relatedContact {get; set;}
        public List<Case> relatedCase {get; set;}
        public List<Opportunity> relatedOpportuinty {get; set;}
    }
    
       
    /*
@AuthorName: Ayush Patial
@Created Date: 24 July 2024
@Last ModifiedDate: 24 July 2024
@Last ModifiedBy: Ayush Patial
@Description: Method to fetch account related data.

*/

    
    public Static List<WrapperClass> AccountRelatedInfo(){
        List<WrapperClass> listOfAccountRelatedRecords = new List<WrapperClass>();
        WrapperClass obj =  new WrapperClass();
        for(Account accRecord : [SELECT ID, Name , (SELECT Id From Contacts), (SELECT Id FROM Cases),(SELECT Id FROM Opportunities) FROM Account LIMIT 10]){
            obj.accountName = accRecord.Name;
            obj.relatedContact = accRecord.Contacts;
            obj.relatedCase = accRecord.Cases;
            obj.relatedOpportuinty = accRecord.Opportunities;
            listOfAccountRelatedRecords.add(obj);
            System.debug(listOfAccountRelatedRecords);
            
        }
         return listOfAccountRelatedRecords;
    }
   
}
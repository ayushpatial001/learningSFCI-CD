public class CustomController {
    
    // this is the one account reference which we used to store data 
    public Account account;
    
    
    public CustomController(){
         account = [SELECT Id, Name, Site,Owner.Name FROM Account 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    }
    
    public Account getAccount(){
        return account;
        
    }
    
    public PageReference save(){
        update account;
        return null;
    }
        

}
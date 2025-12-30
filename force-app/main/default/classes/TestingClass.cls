public class TestingClass {
    Public Static void TestMethod1(){
        List<Id> listOfContactRelatedAccount = new  List<Id>();
        List<Account> listOfAc = [Select Id,name,(Select Id,name from Contacts) from Account];
        for(Account acc : listOfAc){
            listOfContactRelatedAccount.add(acc.Contacts[0].Id);
            
            
        }
    }
}
@isTest
public class ContactDescriptionUpdateTest {
    
    @TestSetup
    public static void makeData(){
        
        List<Account> accountRecord = new List<Account>();
        List<Contact> contactRecord = new  List<Contact>();
        
        
        for(Integer i=0 ; i <= 100 ; i++){
            Account account1 = new Account();
            account1 = DataFactory.createAccount('Account'+ i, False, '123456789012345672','No');
            accountRecord.add(account1);
        }
        
        insert accountRecord;
        
    
            for(Integer i= 0 ; i < 100 ; i++){
                Contact conRecord = new Contact();
                conRecord = DataFactory.createContact(accountRecord[i].Id, 'Contact'+i, 'patial'+i+'ayush3@gmail.com', 'Belongs to');
                contactRecord.add(conRecord);
            }
        
        insert contactRecord;
        
        
        
    }
    
    @isTest
    public static void myFirstTest(){
        List<Contact> listOfContacts = [Select Id FROM Contact];
        Test.startTest();
        ContactDescriptionUpdate batch = new ContactDescriptionUpdate();
        Database.executeBatch(batch);
        Test.stopTest();
        
        System.assertEquals(100,listOfContacts.size());
        
    }
    
}
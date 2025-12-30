@isTest
public class UserTriggerHandlerTest {
    
    @TestSetup
    static void makeData(){
        // Mixed DML Exception occur in this so make sure to use existing user
        User makeUser = DataFactory.createUser('Standard User', 'zuto1', 'seikh12q@gmail.com', 'Seikhqwa', 'seikh12q@gmail.com');
        insert makeUser ;
        Account makeAccount = DataFactory.createAccount('Testing123', False, '123456789012345678', makeUser.Id);
        insert makeAccount;
    }
    
    @isTest
    static void myPositiveCase(){
        
        List<User> user1 = [SELECT Id FROM User WHERE alias = 'zuto1'];
        User checkUser = (User)user1[0];
        
        checkUser.IsActive = False;
        update checkUser;
        System.assertEquals(1,user1.size());
        
        
    }

}
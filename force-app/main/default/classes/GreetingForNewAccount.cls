public with sharing class GreetingForNewAccount {
    private final Account acct;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    
    public GreetingForNewAccount(ApexPages.StandardController sc) {
        this.acct = (Account)sc.getRecord();
    }

    
    public String getGreeting(){
        return 'Hello ' + acct.Name + ' (' + acct.Id + ')';
    }
    
}
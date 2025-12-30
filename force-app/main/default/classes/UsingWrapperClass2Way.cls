public with sharing class UsingWrapperClass2Way {
    
    public class WrapperClass2Way{
        
        public Account acc;
        
        public Integer noOfContacts;
        
        public String billingAddress;
        
        public String  accountName;
        
        public WrapperClass2Way(Account  acc, Integer noOfContacts){
            this.acc = acc;
            this.noOfContacts = noOfContacts;
            this.accountName = acc.Name;
            this.billingAddress = acc.BillingStreet;
        }
        
    }
    
    
    
    
    public static List<WrapperClass2Way> getAccount(){
        
        List<WrapperClass2Way> listOfAccountWrapper = new List<WrapperClass2Way>();
        
        for(Account acc1 : [SELECT ID,Name,BillingStreet,(SELECT Id FROM Contacts) From Account WHERE Name != null And BillingStreet != null limit 5]){
            listOfAccountWrapper.add(new WrapperClass2Way(acc1,acc1.Contacts.size()));
        }
        System.debug(listOfAccountWrapper);
        return listOfAccountWrapper;
    }
    
    
}
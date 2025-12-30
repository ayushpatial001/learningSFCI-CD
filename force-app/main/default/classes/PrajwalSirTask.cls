public class PrajwalSirTask {
    public static void createAccount(String name, String emailOfUser, String phone){
        Account acc = new Account();
        acc.Name = name;
        acc.Email__c = emailOfUser;
        acc.Phone = phone;
        acc.AccountNumber = '123456789012345678';
        
        
        
        Contact con1 = new Contact();
        con1.AccountId = acc.Id;
        con1.LastName = name + '12';
        con1.email = emailOfUser;
        con1.Phone = phone;

        
        try{
            
            insert acc;
            Integer a = 12;
            Integer b = 5;
            Integer c = b / a;
            List<Account>  listOfAccount = [SELECT Id FROM Account WHERE Name = 'wewe'];
            System.debug(listOfAccount[0]);

            
        }catch(DMLException e){
            System.debug(e.getmessage());
            String typeOfException = e.getTypeName();
            Integer lineNumber= e.getLineNumber();
            String message = e.getmessage();
            Custom_Exceptions__c makeRecord = new Custom_Exceptions__c();
            makeRecord.Type__c = typeOfException;
            makeRecord.Exception_line_Number__c = lineNumber;
            makeRecord.Exception_message__c = message;
            insert makeRecord;
            
        }catch(NullPointerException e){
            System.debug(e.getmessage());
            String typeOfException = e.getTypeName();
            Integer lineNumber = e.getLineNumber();
            String message = e.getmessage();
            Custom_Exceptions__c makeRecord = new Custom_Exceptions__c();
            makeRecord.Type__c = typeOfException;
            makeRecord.Exception_line_Number__c = lineNumber;
            makeRecord.Exception_message__c = message;
            insert makeRecord;
            
        }catch(QueryException e){
            System.debug(e.getmessage());
            String typeOfException = e.getTypeName();
            Integer lineNumber = e.getLineNumber();
            String message = e.getmessage();
            Custom_Exceptions__c makeRecord = new Custom_Exceptions__c();
            makeRecord.Type__c = typeOfException;
            makeRecord.Exception_line_Number__c = lineNumber;
            makeRecord.Exception_message__c = message;
            insert makeRecord;
        }
        catch(Exception e){
            System.debug(e.getmessage());
            String typeOfException = e.getTypeName();
            Integer lineNumber = e.getLineNumber();
            String message = e.getmessage();
            Custom_Exceptions__c makeRecord = new Custom_Exceptions__c();
            makeRecord.Type__c = typeOfException;
            makeRecord.Exception_line_Number__c = lineNumber;
            makeRecord.Exception_message__c = message;
            insert makeRecord;
        }
       
    }
    
    public static void updateContactRecord(){
        List<Account> listOfAccountWhereContactPhoneIsNull = [SELECT Id, Phone ,(SELECT Id, Phone FROM Contacts WHERE Phone = null) From Account WHERE Phone != null];
        List<Contact> listContact = new List<Contact>();
        if(!listOfAccountWhereContactPhoneIsNull.isEmpty()){
            for(Account acc123 : listOfAccountWhereContactPhoneIsNull ){
                
                for(Contact con : acc123.Contacts){
                    Contact Rec = new Contact();
                    Rec.Id = con.Id;
                    Rec.Phone = acc123.phone;
                    listContact.add(Rec);
                    
                }
                update listContact;
            }
            
            
        }
        
}
    public static void retrieveAccount(){Contact recordF = new  Contact();
        recordF.LastName = 'Raghunanadan';
        System.debug(recordF);}
    
    
    
}
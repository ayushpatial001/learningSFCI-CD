/*
@Name : AccountTriggerHandler.apxc
@Author Name : Ayush Patial
@Date : 30 July 2024
@Description : This class handle all the functionality when AccountTrigger is triggered

*/

public with sharing class AccountTriggerHandler {
    
    /*
@Name : Ayush Patial
@Description : This method work onAfterInsert when Account record is created and then make contact record related to the Account
@Last Modified By : Ayush Patial

*/
    public static void onAfterInsert(List<Account> accountData){
        
        List<Contact> makeContactRelatedToAccount = new List<Contact>();
        
        if(!accountData.isEmpty() && accountData != null ){
            
            // This loop iterate account record and make contact related to that account when create contact checkbox is true.
            for(Account  accList : accountData)
            {     
                if(accList.Active__c == 'Yes'){
                    System.debug('This account enter in the loop-->'+accList.Create_Contact__c);
                    
                    Contact makeContactRecord = new Contact();
                    makeContactRecord.AccountId = accList.Id;
                    System.debug('AccountId-->'+accList.Id);
                    makeContactRecord.FirstName = accList.Name; 
                    System.debug('AccountName-->'+accList.Name);
                    makeContactRecord.LastName = 'Contact';
                    makeContactRecord.Email = accList.Email__c;
                    System.debug('AccountId-->'+accList.Email__c);
                    makeContactRecord.MobilePhone = accList.Phone;
                    System.debug('thsi is makeing instance of contact-->'+makeContactRecord);
                    makeContactRelatedToAccount.add(makeContactRecord);
                }
                
            }
        }
        
        if(makeContactRelatedToAccount.size()>0){
            try{
                insert makeContactRelatedToAccount;
                System.debug('Make Contact ?'+makeContactRelatedToAccount);
            }catch(DmlException e){
                System.debug(e.getmessage() + e.getLineNumber());
                
            }
        }
        
    }
    
    // Implementation an Apex trigger to prevent the deletion of account if any opportunity, contact, lead, and case if any associated.
    
    public static void onBeforeDelete(List<Account> accountData){
        
        Boolean isrelated = false;
        
        for(Account accountRelatedValues : [SELECT Id,(Select Id From Opportunities),(Select Id From Cases),(Select Id From Contacts) FROM Account Where Id In : accountData]){
            if(accountRelatedValues.Opportunities.size() > 0 || accountRelatedValues.Cases.size() > 0 || accountRelatedValues.Contacts.size() > 0 ){
                isrelated = true;
            }
        }
        
        for(Account accRecord : accountData){
            if(isrelated){
                accRecord.addError('You cannot delete this account because some opportunities associated with this account');
            }
        }
        
        
        
    }
    
    //1.  Develop an Apex trigger that updates a custom field on the Contact object whenever the related Account’s Industry field is changed.
    
    //2.  Write a trigger to throw an error when the user deactivates the account record and if that account has at least one opportunity with the stage not equal to closed won or closed lost.
    
    //3. There will be three Objects User, Contact, and Account. and these objects have one custom field name is isActive. so if I will uncheck the IsActive
    //  Checkbox from the Account then also uncheck the isActive checkbox of the related user of that account and all the contact associate with the account.
    
    
    
    public static void onAfterUpdate(List<Account> accountDate, Map<Id, Account> mapOfOldAccount){
        
        Set<Id> setOfAccountId = mapOfOldAccount.KeySet();
        Set<Id> setOfOwnerId = new Set<Id>();
        
        // This is list use for find out opportunity whose stage is not closed won and closed lost.
        List<Opportunity> listOfOpportunity = [SELECT Id, AccountId,StageName FROM Opportunity where AccountId IN : setOfAccountId And StageName != 'Closed Won' And stageName != 'Closed Lost'];
        
        // This list is used to Deadactive Contact when account is deactve 
        List<Contact> deactiveContact = [Select Id, IsActive__c, AccountId From Contact Where AccountId IN : setOfAccountId];
        
        // User userOfThatAccount = [Select Id,IsActive From User Where Id IN : setOfOwnerId limit 1];
        
        Map<Id,List<contact>> conMap = new Map<Id,List<contact>>();
        List<contact> deactContact = new List<contact>();
        
        // This is used to store id of OwnerId of this account to get user of this Account
        for(Account key : accountDate){
            setOfOwnerId.add(mapOfOldAccount.get(key.Id).OwnerId);
        }
        
        
        
        Map<Id, List<Contact>> mapOfRelatedContact = new Map<Id, List<Contact>>();
        
        for(Contact con : [SELECT Id,AccountId, IndustryFieldOnAccount__c FROM Contact Where AccountId IN : setOfAccountId]){
            if(mapOfRelatedContact.containsKey(con.AccountId)){
                mapOfRelatedContact.get(con.AccountId).add(con);
            } else{
                mapOfRelatedContact.put(con.AccountId, new List<Contact>{con});
            }
            
        }
        
        // Check user wants to deactivate the account or not 
        
        for(contact conRecord:deactiveContact){
            if(!conMap.containsKey(conRecord.AccountId)){
                conMap.put(conRecord.AccountId,new List<contact>());
            }    
            conMap.get(conRecord.AccountId).add(conRecord);
        }
        
        System.debug(' Filled Map---> '+mapOfRelatedContact);
        
        List<Contact> toUpdateIndustry = new List<Contact>();
        Set<Id> setOfOwnerIdWhoAreDeactivated = new Set<Id>();
        
        // Here firstly i do both work in same loop but somehow both functionality not working properly so i seprate the loop
        // Functionality 1
        for(Account acc : accountDate){
            if(acc.Active__c == 'No'){
                if(listOfOpportunity.size() > 0){
                    acc.adderror('You cannot deactivate this account');
                }else{
                    setOfOwnerIdWhoAreDeactivated.add(acc.OwnerId);
                    List<Contact> contactUses = mapOfRelatedContact.get(acc.Id);
                    if(conMap.containskey(acc.id)){
                        deactContact.addAll(conMap.get(acc.id));
                    }      
                }
            }
            
            // Functionality 2
            for(Account accRecord : accountDate){
                if(accRecord.Industry != mapOfOldAccount.get(accRecord.Id).Industry){
                    System.debug('new vlaue-->'+acc.Industry);
                    System.debug('old value-->'+mapOfOldAccount.get(accRecord.Id).Industry);
                    // mapOfRelatedContact.get(acc.Id).get(Id).IndustryFieldOnAccount__c = 'change it';
                    List<Contact> conList = mapOfRelatedContact.get(accRecord.Id);
                    toUpdateIndustry.addAll(conList); 
                }
            }
            
            
            List<contact> storeUpdateonContact = new List<contact>();
            for(contact c:deactContact){
                c.IsActive__c = 'No';
                storeUpdateonContact.add(c);
            }
            
            // store the changes
            
            List<contact> storeUpdationOnActiveFieldOnContact = new List<contact>();
            for(Contact conRecord : deactiveContact){
                conRecord.IsActive__c = 'No';
                storeUpdationOnActiveFieldOnContact.add(conRecord);
                
            }
            
            // update Industry field
            List<contact> updateIndustryField = new List<contact>();
            for(contact conRecord : toUpdateIndustry){
                conRecord.IndustryFieldOnAccount__c = 'Change The values';
                updateIndustryField.add(conRecord);
            }
            try{
                if(updateIndustryField.size()>0){
                    update updateIndustryField;
                }
                if(storeUpdationOnActiveFieldOnContact.size() > 0){
                    update storeUpdationOnActiveFieldOnContact;
                }
                
                if(!storeUpdateonContact.isEmpty()){
                    update storeUpdateonContact;
                }
                
            }catch(DMLException e){
                System.debug(e.getmessage());
            }
            
            
            
            
        }
        AccountTriggerHandler.deactivateUser(setOfOwnerIdWhoAreDeactivated);
        
    }
    
    @future 
    public static void deactivateUser(Set<Id> ownerId){
        List<User> userWHoGotDeactivated = new List<User>();
        
        for(User u : [Select Id, IsActive From User Where Id IN : ownerId]){
            User user1 = new User();
            user1.IsActive = False;
            userWHoGotDeactivated.add(user1);
            
        }
        try{
            update userWHoGotDeactivated;
            
        }catch(DMLException e){
            System.debug(e.getmessage());
        }
        
        
    }
    
    
    
}
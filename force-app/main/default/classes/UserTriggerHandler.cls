/*
    @Name : UserTriggerHandler.apxc
    @AuthorName : Ayush Patial
    @Description : This class is used to perform acttion when a new user is created
    @Created Date : 1 Aug 2024
    
    
    */
    
    public class UserTriggerHandler {
        
        /*
    @Name : Ayush
    @LastModified on : 1 Aug 2024
    @Description : This method call After user created and automatic assign permission set to user
    */
        
        public static void onAfterInsert(List<User> listOfUser){
            
            //store permission set
            List<PermissionSet> listOfPermissionSet = [SELECT Id From PermissionSet Where Name = 'Auto_Assign_Permission_Set' limit 1];
            System.debug(listOfPermissionSet);
            
            //store the permissionset where we assign the user and his permission
            List<PermissionSetAssignment> listOfPermissionAssignments = new List<PermissionSetAssignment>();
            
            for(User user : listOfUser){
                PermissionSetAssignment setAssignment = new PermissionSetAssignment();
                
                setAssignment.AssigneeId = user.Id;
                setAssignment.ExpirationDate = Date.Today().addDays(30);
                setAssignment.PermissionSetId = listOfPermissionSet[0].Id;
                listOfPermissionAssignments.add(setAssignment);
            }
            
            System.debug(listOfPermissionAssignments);
            if(!listOfPermissionAssignments.isEmpty()){
                try{
                    insert listOfPermissionAssignments;
                }catch(DMLException e){
                    System.debug('Error occured-->' + e.getmessage());
                }
                
            }
            
            
            
        }
        
        
        // If I will deactivate the user and if any account, contact and opportunity object record is associate with the user, then through an error "Account, 
        // Contact and Opportunity Record is associate with that records."
        
        public static void onAfterUpdate(List<User> listOfUser){
            Set<Id> setOfUserId = new Set<Id>();
            for(User userId : listOfUser){
                setOfUserId.add(userId.Id);
            }
            
            Map<Id, List<Account>> mapOfUserWithHisAccount = new Map<Id, List<Account>>();
            
            for(Account accRecord : [SELECT Id, Name, OwnerId FROM Account Where OwnerId IN : setOfUserId]){
                if(mapOfUserWithHisAccount.isEmpty()){
                    mapOfUserWithHisAccount.put(accRecord.OwnerId, new List<Account>{accRecord});       
                }else{
                    mapOfUserWithHisAccount.get(accRecord.OwnerId).add(accRecord);
                }
            }
            
            for(User userId : listOfUser){
                List<Account> accList= mapOfUserWithHisAccount.get(userId.Id);
                System.debug('Account size--> ' +accList.size());
                if(!accList.isEmpty()){
                    if( accList.size()   > 0 ){
                        userId.addError('Cannot deactivate the user because of associated acount');
                    }
                }
                
            }
            
            
        }
        
        // When the user is deactivated then its related Accounts and opportunities will automatically assign to its manager.
        
        public static void AssignToManager (Map<Id, User> mapOfUserRecords) {
            
            Set<Id> setOfUserIdsToDeactivate = new Set<Id>();
            Map<Id, Id> mapOfUserManage = new Map<Id, Id>();
            
            // Identify users being deactivated and their managers
            for (User usr : mapOfUserRecords.values()) {
                if (!usr.IsActive && usr.ManagerId != null) {
                    setOfUserIdsToDeactivate.add(usr.Id);
                    mapOfUserManage.put(usr.Id, usr.ManagerId);
                }
            }
            
            if (!setOfUserIdsToDeactivate.isEmpty()) {
                List<Account> accountsToUpdate = [SELECT Id, OwnerId FROM Account WHERE OwnerId IN :setOfUserIdsToDeactivate];
                List<Opportunity> opportunitiesToUpdate = [SELECT Id, OwnerId FROM Opportunity WHERE OwnerId IN :setOfUserIdsToDeactivate];
                
                List<Account> accountUpdates = new List<Account>();
                List<Opportunity> opportunityUpdates = new List<Opportunity>();
                
                System.debug('Accounts to Update: ' + accountsToUpdate);
                System.debug('Opportunities to Update: ' + opportunitiesToUpdate);
                
                for (Account acc : accountsToUpdate) {
                    acc.OwnerId = mapOfUserManage.get(acc.OwnerId);
                    accountUpdates.add(acc);
                }
                
                for (Opportunity opp : opportunitiesToUpdate) {
                    opp.OwnerId = mapOfUserManage.get(opp.OwnerId);
                    opportunityUpdates.add(opp);
                }
                
                System.debug('Account Updates: ' + accountUpdates);
                System.debug('Opportunity Updates: ' + opportunityUpdates);
                
                if (!accountUpdates.isEmpty()) {
                    update accountUpdates;
                }
                if (!opportunityUpdates.isEmpty()) {
                    update opportunityUpdates;
                }
            }
        }
        
        
        
        
    }
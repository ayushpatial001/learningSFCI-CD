trigger dssd on LogoutEventStream (after insert) {
    if(trigger.isInsert){
        if(trigger.isAfter){
            Contact makeNewContact = new Contact();
            makeNewContact.lastName = 'MakeNewRecord';
            
            insert makeNewContact;
        }
    }
}
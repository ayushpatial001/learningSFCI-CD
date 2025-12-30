trigger PreventDuplicatesContat on Contact (before insert) {
    
    String contactEmail;
    for(Contact conRecord : Trigger.new){
        contactEmail =  conRecord.Email;
    }
    
    List<Contact> listOfContact = [SELECT Email FROM Contact WHERE Email  =:  contactEmail];
    
    for(Contact con : Trigger.new){
        /*if(listOfContact[0].Email == con.Email){
            con.addError('Please add unique email');
        }*/
    }
    
    

}
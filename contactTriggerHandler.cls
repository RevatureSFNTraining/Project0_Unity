public class contactTriggerHandler {
    public contactTriggerHandler(list<Contact> newContacts) {
        //undelete contact when creating new contact if found in recycle bin
        list<Contact> oldContacts = [SELECT Id, Name, Email, IsDeleted FROM Contact WHERE IsDeleted = true ALL ROWS];
        for (integer i = 0; i < newContacts.size(); i++) {
            for(integer a = 0; a < oldContacts.size(); a++) {
                if (newContacts[i].Email == oldContacts[a].Email) {
        			undelete oldContacts[a];
                    system.debug('Contact ' + oldContacts[a].Name + ' has been undeleted.');
                    newContacts[i].addError('A previously deleted Contact has been found with that email. It has been returned from the recycle bin.');
                //emails should be unique, break/return after found???
                }
            }
        }
    }
}
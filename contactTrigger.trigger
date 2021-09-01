trigger contactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on Trigger.OperationType {
        when BEFORE_INSERT {
            //when creating new contact, check to see if the contact is already in recycle bin, and reinstate it if so
            ContactTriggerHandler cth = new contactTriggerHandler(Trigger.new);
        } when BEFORE_UPDATE {

        } when BEFORE_DELETE {

        } when AFTER_INSERT {

        } when AFTER_UPDATE {
            
        } when AFTER_DELETE {

        } when AFTER_UNDELETE {

        }
    }
}
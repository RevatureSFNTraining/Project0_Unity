trigger shipTrigger on Ship__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	switch on Trigger.OperationType {
        when BEFORE_INSERT {
            //when creating a new ship, check to make sure name isn't already taken
            ShipTriggerHandler sth = new shipTriggerHandler(Trigger.new);
        } when BEFORE_UPDATE {

        } when BEFORE_DELETE {

        } when AFTER_INSERT {

        } when AFTER_UPDATE {
            
        } when AFTER_DELETE {

        } when AFTER_UNDELETE {

        }
    }
}
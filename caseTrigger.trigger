trigger caseTrigger on Case (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    switch on Trigger.OperationType {
        when BEFORE_INSERT {

        } when BEFORE_UPDATE {

        } when BEFORE_DELETE {

        } when AFTER_INSERT {

        } when AFTER_UPDATE {
            //if case is closed, assign employee as owner of next case
            CaseTriggerHandler cth = new CaseTriggerHandler(Trigger.new);
        } when AFTER_DELETE {

        } when AFTER_UNDELETE {

        }
    }
}
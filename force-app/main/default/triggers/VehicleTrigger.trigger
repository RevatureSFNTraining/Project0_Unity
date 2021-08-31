trigger VehicleTrigger on Vehicle__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            VehicleTriggerHandler.checkContractStatus(Trigger.new);
            VehicleTriggerHandler.checkVehicleStatus(Trigger.new);
        }
        when BEFORE_UPDATE {
            VehicleTriggerHandler.checkContractStatus(Trigger.new);
            VehicleTriggerHandler.checkVehicleStatus(Trigger.new);
        }
        when BEFORE_DELETE {
            
        }
        when AFTER_INSERT {
            
        }
        when AFTER_UPDATE {
            
        }
        when AFTER_DELETE {
            
        }
        when AFTER_UNDELETE {
            
        }
    }
}
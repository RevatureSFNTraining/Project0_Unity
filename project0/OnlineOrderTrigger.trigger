trigger OnlineOrderTrigger on Online_Order__c (before insert, before update, before delete, after insert, after update, after delete, after undelete){
    switch on trigger.operationType {
        when BEFORE_INSERT{
            OnlineOrderTriggerHandler.checkForInventory(Trigger.New);     
        }
        when BEFORE_UPDATE {
            
        }
        when BEFORE_DELETE{
            
        }
        when AFTER_INSERT{
            
        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
}
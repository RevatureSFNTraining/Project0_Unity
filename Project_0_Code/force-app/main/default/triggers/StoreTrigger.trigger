/*
*Name: StoreTrigger.apxt
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 8/31/2021
*Description: 
*	When a store is added/inserted a trigger is invoked to create an inventory to correspond with the store	
*/
trigger StoreTrigger on Store__c (before insert, before delete, before update, after insert, after delete, after update, after undelete) 
 {
	switch on Trigger.OperationType
    {
        when BEFORE_INSERT
        {
            
        } // end of case
        when BEFORE_DELETE
        {
            
        } // end of case
        when BEFORE_UPDATE
        {
            
        } // end of case
        when AFTER_INSERT
        {
          // Helper class is called with method to create new inventory
          StoreTriggerHandler.createAnInventory(Trigger.new);
        } // end of case
        when AFTER_UPDATE
        {
            
        } // end of case
        when AFTER_DELETE
        {
            
        } // end of case
        when AFTER_UNDELETE 
        {
            
        } // end of case
        
    } // end of switch
    
} // end of trigger
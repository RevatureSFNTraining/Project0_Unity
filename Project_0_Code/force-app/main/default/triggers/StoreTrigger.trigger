/*
*Name: 
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 8/31/2021
*Description: 
*	
*/
trigger StoreTrigger on Store__c (before insert, before delete, before update, after insert, after delete, after update, after undelete) 
 {
	switch on Trigger.OperationType
    {
        when BEFORE_INSERT
        {
            
        }
        when BEFORE_DELETE
        {
            
        }
        when BEFORE_UPDATE
        {
            
        }
        when AFTER_INSERT
        {
         
          StoreTriggerHandler.createAnInventory(Trigger.new);
        }
        when AFTER_UPDATE
        {
            
        }
        when AFTER_DELETE
        {
            
        }
        when AFTER_UNDELETE 
        {
            
        }
        
    }
    
}
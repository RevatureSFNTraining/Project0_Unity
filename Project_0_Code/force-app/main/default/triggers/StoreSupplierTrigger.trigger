/*
*Name: 
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 8/31/2021
*Description: 
*	
*/

trigger StoreSupplierTrigger on Store_Supplier__c (before insert, before delete, before update, after insert, after delete, after update, after undelete) 
{
   
    
	switch on Trigger.OperationType
    {
        when BEFORE_INSERT
        {
           SupplierTriggerHelper.checkStore(Trigger.new);  
        }
        when BEFORE_DELETE
        {
            
        }
        when BEFORE_UPDATE
        {
          
        }
        when AFTER_INSERT
        {
           //SupplierTriggerHelper.updateStoreInventory(Trigger.new);  
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
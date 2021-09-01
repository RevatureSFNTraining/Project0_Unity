/*
*Name: StoreSupplierTrigger.apxt
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 8/31/2021
*Description: 
*	Trigger is invoked before a new supplier is added/inserted. 
*	The store number will be checked to make sure the store exists
*/

trigger StoreSupplierTrigger on Store_Supplier__c (before insert, before delete, before update, after insert, after delete, after update, after undelete) 
{
   
    
	switch on Trigger.OperationType
    {
        when BEFORE_INSERT
        {
           // call to helper class to check if store is valid
           SupplierTriggerHelper.checkStore(Trigger.new);  
        } // end of case
        when BEFORE_DELETE
        {
            
        } // end of case
        when BEFORE_UPDATE
        {
          
        } // end of case
        when AFTER_INSERT
        {
           
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
    
} //end of trigger
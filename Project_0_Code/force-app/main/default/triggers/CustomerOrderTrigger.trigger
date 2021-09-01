/*
*Name: CustomerOrderTrigger.apxt
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 
*Description: 
*	Trigger fires after Customer Order has been inserted into the org. A new Customer will be created. 
*/


trigger CustomerOrderTrigger on Order__c (before insert, before delete, before update, after insert, after delete, after update, after undelete) 
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
           // call to class and its method to create a new Customer from the order 
            CustomerTriggerHelper.createNewCustomer(Trigger.new); 
            
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
    
} // end of Trigger
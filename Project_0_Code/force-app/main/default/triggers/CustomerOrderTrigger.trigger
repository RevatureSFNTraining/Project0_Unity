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
            
        }
        when BEFORE_DELETE
        {
            
        }
        when BEFORE_UPDATE
        {
            
        }
        when AFTER_INSERT
        {
           
            CustomerTriggerHelper.createNewCustomer(Trigger.new); 
            // call class that has method to create a new Customer with Name and last anm 
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
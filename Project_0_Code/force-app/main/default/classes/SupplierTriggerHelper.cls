/*
*Name: SupplierTriggerHelper.apxc
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 8/31/2021
*Description: 
*	This class will check that before a supplier is added/inserted the store it is corresponding to exists
*/

public class SupplierTriggerHelper 
{

    public static void checkStore(List<Store_Supplier__c> suppliers)
    {
        // list of existing stores
        List<Store__c> currentStores = [SELECT Name FROM Store__c];
        
        // lsit of store names
        List<String> storeNames = new List<String>(); 
        
        // for every store in currentStores add store name to list of names 
        for(Store__c store : currentStores)
        {
            storeNames.add(store.Name);
        } // end of for
        
        
        // add error if store does not exist
        for(Store_Supplier__c s : suppliers)
        {
            if(!storeNames.contains(s.Store_Number__c))
            {
                s.Store_Number__c.addError('Store Number does not exist!');
            } // end of if
       
        } // end of for
        
    } // end of method

} // end of Class
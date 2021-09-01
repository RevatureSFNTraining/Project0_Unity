/*
*Name: 
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 8/31/2021
*Description: 
*	
*/

public class SupplierTriggerHelper 
{

    public static void checkStore(List<Store_Supplier__c> suppliers)
    {
        List<Store__c> currentStores = [SELECT Name FROM Store__c];
        List<String> storeNames = new List<String>(); 
        
        for(Store__c store : currentStores)
        {
            storeNames.add(store.Name);
        }
        
        
        for(Store_Supplier__c s : suppliers)
        {
            
            if(!storeNames.contains(s.Store_Number__c))
            {
                s.Store_Number__c.addError('Store Number does not exist!');
            }
            
           
           
        }
    }
    
  

}
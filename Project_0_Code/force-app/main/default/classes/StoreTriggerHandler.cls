/*
*Name: StoreTriggerHandler.apxc
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 8/31/2021
*Description: 
*	Everytime a new store is created/added a corresponding inventory will be added to 
*/
public class StoreTriggerHandler 
{
    
    public static void createAnInventory(List<Store__c> listOfNewStores)
    {
     	
        List<Store_Inventory__c> storeInventories = new List<Store_Inventory__c>(); 
        
       List <Store_Supplier__c>  supp = [Select Id, Name FROM Store_Supplier__c];

       
       if(supp.size() > 0)
       { 
        	for(Store__c store : listOfNewStores)
        	{
            	Store_Inventory__c temp = new Store_Inventory__c(); 
            	temp.Name = store.Name; 
            	temp.Store__c = store.Id; 
                    
            	System.debug(store);
                
                if(temp.Store__c != null)
            	{
            		
            	
                 	temp.Store_Supplier__c = supp[0].Id; 
                 	storeInventories.add(temp); 
                    
                   
            	}
            }
          
            
        }
      
    	insert storeInventories; 
    }

}
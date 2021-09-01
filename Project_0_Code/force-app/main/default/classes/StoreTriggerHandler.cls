/*
*Name: StoreTriggerHandler.apxc
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 8/31/2021
*Description: 
*	Everytime a new store is created/added a corresponding inventory will be added 
*/
public class StoreTriggerHandler 
{
    
    public static void createAnInventory(List<Store__c> listOfNewStores)
    {
     	 // list of inventories to add
        List<Store_Inventory__c> storeInventories = new List<Store_Inventory__c>(); 
        
        // list of suppliers
		List <Store_Supplier__c>  supp = [Select Id, Name FROM Store_Supplier__c];

       // if there are suppliers, then an inventory can be created
       if(supp.size() > 0)
       { 
           	// for every store in the listofNewStores, a new inventory is created
        	for(Store__c store : listOfNewStores)
        	{
               	// create new inventory
            	Store_Inventory__c temp = new Store_Inventory__c(); 
            	temp.Name = store.Name; 
            	temp.Store__c = store.Id; 
                
                // if store exist, set supplier and add to inventories to be inserted
                if(temp.Store__c != null)
            	{
          			// assign store inventory a supplier
                 	temp.Store_Supplier__c = supp[0].Id; 
                    
                    // add new inventory to list
                 	storeInventories.add(temp); 
            
            	} // end of if
            } // end of for         
        } // end of if
        
      	// insert inventories created
    	insert storeInventories; 
        
    } // end of method

} // end of class
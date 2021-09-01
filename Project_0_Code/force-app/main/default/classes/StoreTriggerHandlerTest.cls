/*
*Name: StoreTriggerHandler.apxc
*Author: Julia Weakley
*DateCreated: 8/30/2021
*DateModified: 8/31/2021
*Description: 
*	Tests for StoreTrigger and StoreTriggerHandler
*	Tests cover StoreTriggerHandler 100%
* 	Test cover StoreTrigger  66%
*/

@isTest
private class StoreTriggerHandlerTest {

    // creates 200 store records to use in test
    @testSetup
    static void setup()
    {
		// Create test account 
        Account sAccount = new Account(); 
     	sAccount.Name = 'New Account';
        insert sAccount; 
       
        // create and fill a list of 200 store records
        List<Store__c> storeList = new List<Store__c>(); 
        for( Integer i=0; i < 200; i++ )
        {
            Store__c store = new Store__c();
       		store.Account__c = sAccount.Id;
       		store.Location__c = 'Salt Lake City';  
       		storeList.add(store);
        } // end of for
       
        // insert list of stores to test if trigger is successful
		insert storeList;
        
    } // end of test 
    
   
    // Tests that no inventories will be added when there are 
    //  no suppliers in org
    @isTest static void createAnInventoryFailTest()
    {
		// Temporary Account used to create store
		Account tempAccount = [SELECT id FROM Account LIMIT 1];
     
		// Creates two new store to pass to the CreateAnInventory method
       Store__c store = new Store__c(); 
       store.Account__c = tempAccount.Id;
       store.Location__c = 'Salt Lake City';  
      
       Store__c storeTwo = new Store__c(); 
       storeTwo.Account__c = tempAccount.Id;
       storeTwo.Location__c = 'Salt Lake City';  
        
		//List to populate with new stores created
		List<Store__c> listOfStores = new List<Store__c>();
       	listOfStores.add(store);
       	listOfStores.add(storeTwo);
    
        
        // pass list into method to create an inventory
        StoreTriggerHandler.CreateAnInventory( listOfStores); 
        
        // grab inventories that exist
      	List <Store_Inventory__c>  inven= [SELECT id FROM Store_Inventory__c]; 
        
        // no inventories should have been added since there are no suppliers
        System.assertEquals(0, inven.size());
       
     } // end of test
    
    
   
    //	Tests what happens when one store is added. 
    //	There should be 1 inventory  created 
    @isTest
    static void createAnInventoryTest()
    {  
        // create supplier to create inventory later
        Store__c storeNameToTake = [SELECT Id, Name FROM Store__c LIMIT 1];
        Store_Supplier__c  aNewSupplier = new Store_Supplier__c(); 
        aNewSupplier.Store_Number__c = storeNameToTake.Name; 
        aNewSupplier.Name = 'testsupplier'; 
        insert aNewSupplier;  
        
		// List of Store to add inventory for
		List<Store__c> listOfStores =  [SELECT Id, Name FROM Store__c LIMIT 1];   
      
		// call to method that creates inventory based on store and supplier
        StoreTriggerHandler.CreateAnInventory( listOfStores); 
         
        // List of Inventories that exist
		List <Store_Inventory__c>  inven= [SELECT Id FROM Store_Inventory__c];
        
        // Test to see that one inventory was added
		System.assertEquals(1, inven.size());

    } // end of test
    
    
    // Test to see if 200 inventories will be added when there are 200 stores 
    @isTest
    static void createManyInventories()
    {
        // Temporary store used to create a supplier record
        Store__c storeNameToTake = [SELECT Id, Name FROM Store__c LIMIT 1];
        
        // create and add a supplier record
        // Supplier record is needed to create an inventory
        Store_Supplier__c  aNewSupplier = new Store_Supplier__c(); 
        aNewSupplier.Store_Number__c = storeNameToTake.Name; 
        aNewSupplier.Name = 'testsupplier'; 
        insert aNewSupplier;  
        
        // create list of stores to make inventories for
        List<Store__c> listOfStores = [SELECT Id, Name From Store__c]; 
        
        // call function to create inventories
        StoreTriggerHandler.CreateAnInventory( listOfStores);
        
		// Retrieve all inventory records that exist
		List <Store_Inventory__c>  inven= [SELECT Id FROM Store_Inventory__c];
        
        // check that all 200 records made it in
      	System.assertEquals(200, inven.size());   
    } // End of Test
    
    
    // if a empty list is passed into the trigger helper method it is handled correclty 
    // and no inventory is added
     @isTest
    static void testForEmpty()
    {
         // create list of stores to make inventories for
        List<Store__c> listOfStores = new List<Store__c>();
        
        // call helper method with empty list
        StoreTriggerHandler.CreateAnInventory(listOfStores);
        
		// Retrieve all inventory records that exist
		List <Store_Inventory__c>  inven= [SELECT Id FROM Store_Inventory__c];
        
        // check that no records were made
      	System.assertEquals(0, inven.size());   
    } // End of Test
} // End of Test class
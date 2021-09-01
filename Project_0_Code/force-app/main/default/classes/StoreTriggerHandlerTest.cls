/*
*Name: StoreTriggerHandler.apxc
*Author: Julia Weakley
*DateCreated: 8/30/2021
*DateModified: 8/31/2021
*Description: 
*	Tests for StoreTrigger and StoreTriggerHandler
*/

@isTest
private class StoreTriggerHandlerTest {

    @testSetup
    static void setup()
    {
       
        Account sAccount = new Account(); 
     	sAccount.Name = 'New Account';
        insert sAccount; 
       
        
        List<Store__c> storeList = new List<Store__c>(); 
        for( Integer i=0; i < 200; i++ )
        {
            Store__c store = new Store__c();
       		store.Account__c = sAccount.Id;
       		store.Location__c = 'Salt Lake City';  
       		storeList.add(store);
        }
       
       insert storeList;
    }
    
    // positive 
    // since there are no suppliers the store will not be  have a corresponding inventory
    // Thus no inventories should have been added
    @isTest static void createAnInventoryFailTest()
    {
       Account tempAccount = [SELECT id FROM Account LIMIT 1];
       List<Store__c> listOfStores = new List<Store__c>();
	   
       Store__c store = new Store__c(); 
       store.Account__c = tempAccount.Id;
       store.Location__c = 'Salt Lake City';  
       listOfStores.add(store);
       
        Store__c storeTwo = new Store__c(); 
       storeTwo.Account__c = tempAccount.Id;
       storeTwo.Location__c = 'Salt Lake City';  
       listOfStores.add(storeTwo);
    
        StoreTriggerHandler.CreateAnInventory( listOfStores); 
        
      	List <Store_Inventory__c>  inven= [SELECT id FROM Store_Inventory__c]; 
        System.assertEquals(0, inven.size());
       
     }
    
    
    // Positvie and single Action test
    // with only one store being added we have 1 inventory being created 
    @isTest
    static void createAnInventoryTest()
    {  
         Store__c storeNameToTake = [SELECT Id, Name FROM Store__c LIMIT 1];
        Store_Supplier__c  aNewSupplier = new Store_Supplier__c(); 
        aNewSupplier.Store_Number__c = storeNameToTake.Name; 
        aNewSupplier.Name = 'testsupplier'; 
        insert aNewSupplier;  
        
        
        Account tempAccount = [SELECT id FROM Account LIMIT 1];
       List<Store__c> listOfStores = new List<Store__c>();
	   
       Store__c testStore = [SELECT Id, Name FROM Store__c LIMIT 1];   
       listOfStores.add(testStore);
      
        StoreTriggerHandler.CreateAnInventory( listOfStores); 
           
      List <Store_Inventory__c>  inven= [SELECT Id FROM Store_Inventory__c]; 
      System.assertEquals(1, inven.size());

    }
    
    // Bulk Test and Postive 
    // Looking for all 200 inventories to be added for the 200 stores
    @isTest
    static void createManyInventories()
    {
        Store__c storeNameToTake = [SELECT Id, Name FROM Store__c LIMIT 1];
        Store_Supplier__c  aNewSupplier = new Store_Supplier__c(); 
        aNewSupplier.Store_Number__c = storeNameToTake.Name; 
        aNewSupplier.Name = 'testsupplier'; 
        insert aNewSupplier;  
        
        List<Store__c> listOfStores = [SELECT Id, Name From Store__c]; 
         StoreTriggerHandler.CreateAnInventory( listOfStores);
          List <Store_Inventory__c>  inven= [SELECT Id FROM Store_Inventory__c]; 
      	System.assertEquals(200, inven.size());   
    }
}
/*
*Name: SupplierTriggerTest.apxc
*Author: Julia Weakley
*DateCreated: 8/30/2021
*DateModified: 8/31/2021
*Description: 
*	Tests for SupplierTriggerHelper and StoreSupplierTrigger
*	Tests cover SupplierTriggerHelper 100%
*	Tests cover StoreSupplierTrigger 66%
*/

@isTest
private class SupplierTriggerTest
{
    
    
    
    
    // Tests that supplier will not be added if a store is entered that does not exist
    // Since there is no store '001' the insert will fail, and no new supplier will be added
    @isTest
    private static void storeNumberCheckTest()
    {
        
        // create store supplier amd set its required values
        Store_Supplier__c supplier = new Store_Supplier__c(); 
        supplier.Name = 'test supplier'; 
        supplier.Store_Number__c = '001'; 
        
        // start test
        Test.startTest();
        // insert supplier and save result of insert 
        Database.SaveResult res = Database.insert(supplier, false); 
        // stop test
        Test.stopTest();
        
        // Verify an error was given 
        System.assert(!res.isSuccess());
        System.assert(res.getErrors().size() > 0);
        System.assertEquals('Store Number does not exist!', res.getErrors()[0].getMessage());
    } // end of test
    
    // Test calls method to insert record, but nothing should have been inserted since there are no 
    // stores saved
    @isTest
    private static void multipleCheckTest()
    {
        // list of store suppliers
        List<Store_Supplier__c> suppliers = new List<Store_Supplier__c> (); 
        
        // create 200 supplier records with random stores
        for(Integer i=0; i < 200; i++)
        {
            Store_Supplier__c supplier = new Store_Supplier__c(); 
            supplier.Name = 'test supplier ' + i ; 
            supplier.Store_Number__c = '00' + i ; 
            suppliers.add(supplier);
        } // end of for
        
        
        // call trigger helper class and method to check if store is valid on the suppliers
        SupplierTriggerHelper.checkStore(suppliers); 
        
        // List of suppliers created
        List<Store_Supplier__c> currentSuppliers = [SELECT Id FROM Store_Supplier__c];
        
        // compare expected to actual results
        System.assertEquals(0, currentSuppliers.size());
        
    } // end of test
    
    // Test checks whether 200 supplier  records can be handled by trigger
    @isTest
    private static void multiplePassTest()
    {
        // Create an Account
        Account tempAccount = new Account(); 
        tempAccount.Name = 'Temporary Test';
        insert tempAccount; 
        
        // create a store
        Store__c testStore = new Store__c(); 
        testStore.Account__c = tempAccount.Id; 
        testStore.Location__c = 'New York';
        insert testStore; 
        
       
        
        // list of store suppliers
        List<Store_Supplier__c> suppliers = new List<Store_Supplier__c> (); 
        
        // Create store
        Store__c storeNum = [SELECT id, Name FROM Store__c LIMIT 1];
        String nameToUse = storeNum.Name;
        
        // create 200 supplier records with store created above
        for(Integer i=0; i < 200; i++)
        {
            Store_Supplier__c supplier = new Store_Supplier__c(); 
            supplier.Name = 'test supplier ' + i ; 
            supplier.Store_Number__c = nameToUse ; 
            System.debug(supplier.Store_Number__c);
            suppliers.add(supplier);
        } // end of for
        
        
        // invoke trigger
        insert suppliers;
        
        // List of suppliers created
        List<Store_Supplier__c> currentSuppliers = [SELECT Id FROM Store_Supplier__c];
        
        // There should be 200 new supplier records 
        System.assertEquals(200, currentSuppliers.size());
        
    } // end of test
     
} // end of test class
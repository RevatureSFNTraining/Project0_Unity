/*
*Name: SupplierTriggerTest.apxc
*Author: Julia Weakley
*DateCreated: 8/30/2021
*DateModified: 8/31/2021
*Description: 
*	Tests for SupplierTriggerHelper and StoreSupplierTrigger
*/
@isTest
private class SupplierTriggerTest
{
    
    
    
    // single Action and Positve Test
    // since there is no store '001' the insert will fail, and no new supplier will be added
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
        
       
        System.assert(!res.isSuccess());
        System.assert(res.getErrors().size() > 0);
        
         // Compare expected to actual result, should have gotten an error
        System.assertEquals('Store Number does not exist!', res.getErrors()[0].getMessage());
        
        
    } // end of test
    
    // BulkTesting (200 records) and Postive Test
    // call method to insert, but nothing should have been inserted since there no stores saved
        @isTest
	private static void multipleCheckTest()
	{
       List<Store_Supplier__c> suppliers = new List<Store_Supplier__c> (); 
      
       for(Integer i=0; i < 200; i++)
       {
           	 Store_Supplier__c supplier = new Store_Supplier__c(); 
        	supplier.Name = 'test supplier ' + i ; 
        	supplier.Store_Number__c = '00' + i ; 
            suppliers.add(supplier);
       } // end of for
        
 
        // call trigger helper class and method
        SupplierTriggerHelper.checkStore(suppliers); 
       
        // gather results from trigger
        List<Store_Supplier__c> currentSuppliers = [SELECT Id FROM Store_Supplier__c];
        
       // compare expected to actual results
       System.assertEquals(0, currentSuppliers.size());
        
	} // end of test
        

}
@isTest
private class TransactionTriggerTest {
    @isTest static void SingleTest(){
        Sportswear_Company__c sportsTest = new Sportswear_Company__c(Name = 'Boston Store Numbers');
        insert sportsTest;
        Retail_Store__c retailStoreTest = new Retail_Store__c(Name = 'Boston Store', Store_ID__c ='123456', Store_Address__c = '123 Test St.', Store_Phone_Number__c = '123-456-7890', Sportswear_Company__c = sportsTest.Id);
        insert retailStoreTest;
        Supplier__c supplierTest = new Supplier__c(Name = 'Ball Supplier', Supplier_ID__c = '123456789');
        insert supplierTest;
        Inventory__c inventoryTest= new Inventory__c(Name = 'Ball', Brand__c = 'Wilson', Price__c = 50, Quantity__c = 10, Size__c = 'Men', Retail_Store__c = retailStoreTest.Id, Supplier__c = supplierTest.Id);
        insert inventoryTest;
        Customer__c customerTest = new Customer__c(Name = 'John', Email_Address__c = 'test@test.com', Address__c = '123 Test St.', Phone_Number__c = '123-456-7890');
        insert customerTest;
        Transaction__c transactionTest = new Transaction__c(Name = 'James', Customer__c = customerTest.Id, Retail_Store__c = retailStoreTest.Id, Inventory__c = inventoryTest.Id, Quantity__c = 5);
        insert transactionTest;
        Inventory__c newInventory = [SELECT id, Quantity__c FROM Inventory__c Where Name = 'Ball'];
        System.assertEquals(5, newInventory.Quantity__c);
    }
    @isTest static void BulkTest(){
        Sportswear_Company__c sportsTest = new Sportswear_Company__c(Name = 'Boston Store Numbers');
        insert sportsTest;
        Retail_Store__c retailStoreTest = new Retail_Store__c(Name = 'Boston Store', Store_ID__c ='123456', Store_Address__c = '123 Test St.', Store_Phone_Number__c = '123-456-7890', Sportswear_Company__c = sportsTest.Id);
        insert retailStoreTest;
        Supplier__c supplierTest = new Supplier__c(Name = 'Ball Supplier', Supplier_ID__c = '123456789');
        insert supplierTest;
        Inventory__c inventoryTest= new Inventory__c(Name = 'Ball', Brand__c = 'Wilson', Price__c = 50, Quantity__c = 1000, Size__c = 'Men', Retail_Store__c = retailStoreTest.Id, Supplier__c = supplierTest.Id);
        insert inventoryTest;
        Customer__c customerTest = new Customer__c(Name = 'John', Email_Address__c = 'test@test.com', Address__c = '123 Test St.', Phone_Number__c = '123-456-7890');
        insert customerTest;
        List<Transaction__c> bulkTransactions = new List<Transaction__c>();
        for(Integer i = 0;i < 200; i++){
            Transaction__c transactionTest = new Transaction__c(Name = 'James ', Customer__c = customerTest.Id, Retail_Store__c = retailStoreTest.Id, Inventory__c = inventoryTest.Id, Quantity__c = 5);
        	bulkTransactions.add(transactionTest);
        }
        insert bulkTransactions;
        Inventory__c newInventory = [SELECT id, Quantity__c FROM Inventory__c Where Name = 'Ball'];
        System.assertEquals(0, newInventory.Quantity__c);
    }
    @isTest static void NegativeTest(){
        //boolean result = false;
        Sportswear_Company__c sportsTest = new Sportswear_Company__c(Name = 'Boston Store Numbers');
        insert sportsTest;
        Retail_Store__c retailStoreTest = new Retail_Store__c(Name = 'Boston Store', Store_ID__c ='123456', Store_Address__c = '123 Test St.', Store_Phone_Number__c = '123-456-7890', Sportswear_Company__c = sportsTest.Id);
        insert retailStoreTest;
        Supplier__c supplierTest = new Supplier__c(Name = 'Ball Supplier', Supplier_ID__c = '123456789');
        insert supplierTest;
        Inventory__c inventoryTest= new Inventory__c(Name = 'Ball', Brand__c = 'Wilson', Price__c = 50, Quantity__c = 10, Size__c = 'Men', Retail_Store__c = retailStoreTest.Id, Supplier__c = supplierTest.Id);
        insert inventoryTest;
        Customer__c customerTest = new Customer__c(Name = 'John', Email_Address__c = 'test@test.com', Address__c = '123 Test St.', Phone_Number__c = '123-456-7890');
        insert customerTest;
        try{
            Transaction__c transactionTest = new Transaction__c(Name = 'James', Customer__c = customerTest.Id, Retail_Store__c = retailStoreTest.Id, Inventory__c = 'Basketball', Quantity__c = 5);
        	insert transactionTest;
        } catch(System.StringException invalidId){
            //result = true;
            System.debug('An exception occured: ' + invalidId.getMessage() + '. This product is not currently in the Inventory');
        }
        //System.assertEquals(true, result);
    }
}
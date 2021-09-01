@isTest
public class OnlineOrderTriggerTest {
    @isTest static void SingleTest(){
        Sportswear_Company__c sportsTest = new Sportswear_Company__c(Name = 'Boston Store Numbers');
        insert sportsTest;
        Retail_Store__c retailStoreTest = new Retail_Store__c(Name = 'Boston Store', Store_ID__c ='123456', Store_Address__c = '123 Test St.', Store_Phone_Number__c = '123-456-7890', Sportswear_Company__c = sportsTest.Id);
        insert retailStoreTest;
        Supplier__c supplierTest = new Supplier__c(Name = 'Ball Supplier', Supplier_ID__c = '123456789');
        insert supplierTest;
        Inventory__c inventoryTest= new Inventory__c(Name = 'Ball', Brand__c = 'Wilson', Price__c = 50, Quantity__c = 1, Size__c = 'Men', Retail_Store__c = retailStoreTest.Id, Supplier__c = supplierTest.Id);
        insert inventoryTest;
        Online_Order__c onlineOrderTest = new Online_Order__c(Name = 'Sam', Order_Date__c = Date.today(), Inventory__c = inventoryTest.Id, Quantity__c = 2, Retail_Store__c = retailStoreTest.Id, Order_Status__c = 'Delivered');
        Database.SaveResult sr = DataBase.insert(onlineOrderTest, false);
        Integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
        }
        System.assertEquals(1, numFailed);
    }
    @isTest static void BulkTest(){
        Sportswear_Company__c sportsTest = new Sportswear_Company__c(Name = 'Boston Store Numbers');
        insert sportsTest;
        Retail_Store__c retailStoreTest = new Retail_Store__c(Name = 'Boston Store', Store_ID__c ='123456', Store_Address__c = '123 Test St.', Store_Phone_Number__c = '123-456-7890', Sportswear_Company__c = sportsTest.Id);
        insert retailStoreTest;
        Supplier__c supplierTest = new Supplier__c(Name = 'Ball Supplier', Supplier_ID__c = '123456789');
        insert supplierTest;
        Inventory__c inventoryTest= new Inventory__c(Name = 'Ball', Brand__c = 'Wilson', Price__c = 50, Quantity__c = 1, Size__c = 'Men', Retail_Store__c = retailStoreTest.Id, Supplier__c = supplierTest.Id);
        insert inventoryTest;
        List<Online_Order__c> testingOrders = new List<Online_Order__c>();
        for(Integer i = 0; i < 200; i++){
            testingOrders.add(new Online_Order__c(Name = 'Sam ' + i, Order_Date__c = Date.today(), Inventory__c = inventoryTest.Id, Quantity__c = 2, Retail_Store__c = retailStoreTest.Id, Order_Status__c = 'Delivered'));
        }
        List<DataBase.SaveResult> srs = DataBase.insert(testingOrders, false);
        Integer numFailed = 0;
        for(DataBase.SaveResult sr : srs){
            if(!sr.isSuccess()){
                numFailed += 1;
            }
        }
        System.assertEquals(200, numFailed);
    }
    @isTest static void NegativeTest(){
        Sportswear_Company__c sportsTest = new Sportswear_Company__c(Name = 'Boston Store Numbers');
        insert sportsTest;
        Retail_Store__c retailStoreTest = new Retail_Store__c(Name = 'Boston Store', Store_ID__c ='123456', Store_Address__c = '123 Test St.', Store_Phone_Number__c = '123-456-7890', Sportswear_Company__c = sportsTest.Id);
        insert retailStoreTest;
        Supplier__c supplierTest = new Supplier__c(Name = 'Ball Supplier', Supplier_ID__c = '123456789');
        insert supplierTest;
        Inventory__c inventoryTest= new Inventory__c(Name = 'Ball', Brand__c = 'Wilson', Price__c = 50, Quantity__c = 1, Size__c = 'Men', Retail_Store__c = retailStoreTest.Id, Supplier__c = supplierTest.Id);
        insert inventoryTest;
        try{
            Online_Order__c onlineOrderTest = new Online_Order__c(Name = 'Sam', Order_Date__c = Date.today(), Inventory__c = 'basketball', Quantity__c = 2, Retail_Store__c = retailStoreTest.Id, Order_Status__c = 'Delivered');
            insert onlineOrderTest;
        } catch (System.StringException e){
            System.debug('The following exception has occured: ' + e.getMessage());
        }
    }
}
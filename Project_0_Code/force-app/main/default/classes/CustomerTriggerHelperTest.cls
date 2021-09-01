/*
*Name: CustomerTriggerHelperTest.apxc
*Author: Julia Weakley
*DateCreated: 8/31/2021
*DateModified: 8/31/2021
*Description: 
*	Tests CustomerOrderTrigger and CustomerTriggerHelper
*	Tests cover CustomerTriggerHelper 100%
*	Test cover CustomerOrderTrigger 66%
*
*/

@isTest
private class CustomerTriggerHelperTest
{
    // Tests getCustomer method, thus given a customer that is in the customerlist can
    // be found by the method
    @isTest
    private static void getCustomerTest()
    {
        // list of customers
        List<Customer__c> currentL = new List<Customer__c>(); 
        
        // adds customer to list
        Customer__c newCustomer = new Customer__c(); 
        newCustomer.Name = 'Julia'; 
        currentL.add(newCustomer); 
        
        // calls method to find customer that matches the name given
        Customer__c customer = CustomerTriggerHelper.getCustomer('Julia', currentL); 
       
        // correct customer should have been returned
        System.assertEquals(newCustomer, customer); 
    } // end of test
    
    
    // Tests that the getcustomer method can an instance of where the customer they
    // are trying to find is not in the list
    @isTest
    private static void getCustomerNullTest()
    {
        // create list of customers 
        List<Customer__c> customerList = new List<Customer__c>(); 
        
        // create a new customer and add to list
        Customer__c newCustomer = new Customer__c(); 
        newCustomer.Name = 'rob';
        customerList.add(newCustomer); 
        
        // call getCustomer mehtod
        Customer__c customer = CustomerTriggerHelper.getCustomer('Julia', customerList); 
        
        // method should have returned null since the customer it is looking for is not in the list
        System.assertEquals(null, customer); 
        
    } // end of test
    
    
    // Tests if New customer is created from a new Order that was inserted
    @isTest
    private static void createNewCustomerTest()
    {
        // list of customer orders
        List<Order__c> orderList = new List<Order__c>(); 
        
        // new customer order that gets added to list of orders
        Order__c order = new Order__c(); 
        order.Name = 'Julia'; 
        order.Customer_Last_Name__c = 'Weakley'; 
        orderList.add(order); 
        
        // call method to create new customers from orders
        CustomerTriggerHelper.createNewCustomer(orderList);
        
        // retrieve customers that exist
        List<Customer__c> customerList = [SELECT Id FROM Customer__c]; 
        
        // if customer was added correctly there should be  1
        System.assertEquals(1,customerList.size());
        
    } // end of test
    
    
    // Test checks that trigger is being fired when new order is inserted 
    @isTest
    private static void CustomerOrderTriggerTest()
    {
        // create new order to test
        Order__c order = new Order__c(); 
        order.Name = 'Julia'; 
        order.Customer_Last_Name__c = 'Weakley'; 
        order.Date__c = date.today(); 
        
        // insert order invoking trigger
        insert order; 
        
        // Retrieve customers that exist
        List<Customer__c> customerList = [SELECT Id FROM Customer__c]; 
        
        // Check that 1 customer was added
        System.assertEquals(1,customerList.size());
    } // end of test
    
    
    // Tests whether 200 order records will create 200 customer records
    private static void createManyCustomersTest()
    {
        // list of orders
        List<Order__c> orderList = new List<Order__c>(); 
        
        // adds 200 orders to list
        for(Integer i =0; i < 200; i++)
        {
            Order__c order = new Order__c(); 
            order.Name = 'Julia'; 
            order.Customer_Last_Name__c = 'Weakley' + i; 
            orderList.add(order); 
        }
        
        // calls method to create customers
        CustomerTriggerHelper.createNewCustomer(orderList);
        
        // Retrieve all customers that exist
        List<Customer__c> customerList = [SELECT Id FROM Customer__c]; 
        
        // check that customers were added correctly 
        // There should be 200 
        System.assertEquals(200,customerList.size());
    } // end of test
    
    
    // Tests that the number of visits increase when a customer makes more orders
    @isTest
    private static void multipleVisistsTest()
    {
        // create and insert order
        Order__c order = new Order__c(); 
        order.Name = 'Julia'; 
        order.Customer_Last_Name__c = 'Weakley'; 
        order.Date__c = date.today(); 
        insert order; 
        
        // create another order by the same customer
        Order__c orderTwo = new Order__c(); 
        orderTwo.Name = 'Julia'; 
        orderTwo.Customer_Last_Name__c = 'Weakley'; 
        
        // create and add customer to a list of orders
        List<Order__c> orderList = new List<Order__c>();
        orderList.add(orderTwo); 
        
        // call method for creating customers
        CustomerTriggerHelper.createNewCustomer(orderList);
        
        // retrieve all customers that exist
        Customer__c customerCheck = [SELECT Number_of_Visits__c FROM Customer__c WHERE Name = 'Julia Weakley']; 
        
        // number of visits on the customer should be 2
        System.assertEquals(2,customerCheck.Number_of_Visits__c);
  
    } // end of test
    
    
} // end of test class
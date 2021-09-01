/*
*Name: CustomerTriggerHelperTest.apxc
*Author: Julia Weakley
*DateCreated: 8/31/2021
*DateModified: 8/31/2021
*Description: 
*	Tests CustomerOrderTrigger and CustomerTriggerHelper
*/

// Single Action and Positive Test 
// New Customer matches the results of getCustomer
@isTest
private class CustomerTriggerHelperTest
{

    @isTest
    private static void getCustomerTest()
    {
        List<Customer__c> currentL = new List<Customer__c>(); 
        Customer__c newCustomer = new Customer__c(); 
        newCustomer.Name = 'Julia'; 
        currentL.add(newCustomer); 
        
        Customer__c customer = CustomerTriggerHelper.getCustomer('Julia', currentL); 
        System.assertEquals(newCustomer, customer); 
    }
    
    // Single Action and Positive
    // getcustomer is looking for a customer that is not listed
    @isTest
    private static void getCustomerNullTest()
    {
        List<Customer__c> currentL = new List<Customer__c>(); 
        Customer__c newCustomer = new Customer__c(); 
        newCustomer.Name = 'rob';
        currentL.add(newCustomer); 
        
        Customer__c customer = CustomerTriggerHelper.getCustomer('Julia', currentL); 
        System.assertEquals(null, customer); 
    }
    
    // Single and Positive 
    // New customer is created from a new Order being inserted
    @isTest
    private static void createNewCustomerTest()
    {
        List<Order__c> orderList = new List<Order__c>(); 
        Order__c order = new Order__c(); 
        order.Name = 'Julia'; 
        order.Customer_Last_Name__c = 'Weakley'; 
        orderList.add(order); 
        
     	CustomerTriggerHelper.createNewCustomer(orderList);

		List<Customer__c> customerList = [SELECT Id FROM Customer__c]; 
        
        // if customer was added correctly there should be a size of 1
     	 System.assertEquals(1,customerList.size());
    }
    
    // Single Action and Positive 
    // Checks that trigger is being fired when new order is inserted 
    @isTest
    private static void CustomerOrderTriggerTest()
    {
          List<Order__c> orderList = new List<Order__c>(); 
        Order__c order = new Order__c(); 
        order.Name = 'Julia'; 
        order.Customer_Last_Name__c = 'Weakley'; 
        order.Date__c = date.today(); 
        
        insert order; 
        
        List<Customer__c> customerList = [SELECT Id FROM Customer__c]; 
         System.assertEquals(1,customerList.size());
    }
    
    
    // Bulk and Positve Test on helper method of trigger
     private static void createManyCustomersTest()
    {
        List<Order__c> orderList = new List<Order__c>(); 
       
        for(Integer i =0; i < 200; i++)
        {
        	Order__c order = new Order__c(); 
        	order.Name = 'Julia'; 
        	order.Customer_Last_Name__c = 'Weakley' + i; 
        	orderList.add(order); 
        }
        
     	CustomerTriggerHelper.createNewCustomer(orderList);

		List<Customer__c> customerList = [SELECT Id FROM Customer__c]; 
        
        // if customer was added correctly there should be a size of 1
     	 System.assertEquals(200,customerList.size());
  
    }
    
     // Single Action and Positive 
    // Checks that the number of visits increase when a customer returns
     @isTest
    private static void multipleVisistsTest()
    {
         
        Order__c order = new Order__c(); 
        order.Name = 'Julia'; 
        order.Customer_Last_Name__c = 'Weakley'; 
        order.Date__c = date.today(); 
       	insert order; 
        
        
        Order__c orderTwo = new Order__c(); 
        orderTwo.Name = 'Julia'; 
        orderTwo.Customer_Last_Name__c = 'Weakley'; 
        
        List<Order__c> orderList = new List<Order__c>();
        orderList.add(orderTwo); 
        
     	CustomerTriggerHelper.createNewCustomer(orderList);

		Customer__c customerCheck = [SELECT Number_of_Visits__c FROM Customer__c LIMIT 1]; 
        
        // if customer was added correctly there should be a size of 1
     	 System.assertEquals(2,customerCheck.Number_of_Visits__c);
        
        
      
    }
    
    
}
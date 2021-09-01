/*
*Name: CustomerTriggerHelper.apxc
*Author: Julia Weakley
*DateCreated: 8/26/2021
*DateModified: 8/31/2021
*Description: 
*	Creates a new customer for every new order. If there is a customer that 
*	already exists number of visits increase
*/



public class CustomerTriggerHelper 
{
	
    public static void createNewCustomer(List<Order__c> orderList)
    {
    
        // Customers to add a record for in Salesforce
        List<Customer__c> customerList = new List<Customer__c>(); 
        
        // Customer records  to update 
        List<Customer__c> customersToUpdate = new List<Customer__c>();
        
        // list of current customers
        List <Customer__c> currentL = [SELECT Name, ID, Number_of_Visits__c FROM Customer__c]; 
        
        // temporary list holding the names of current customers
        List <String> tempList = new List<String>(); 
        
        // adds names to temporary name list 
        for(Customer__c cus : currentL)
        {
            tempList.add(cus.Name);
        } // end of for
        
        
        
        for(Order__c order: orderList)
        {
            // combines firstname and lastname of customer on Order 
            String customerName = order.Name + ' '+ order.Customer_Last_Name__c; 
            
            // check if customer has a history at the company
           	if(tempList.contains(customerName))
            {
                // grab customer account/record
                Customer__c tempCustomer = getCustomer(customerName, currentL);
            
                
                // increase number of visits by 1 
                Integer visits = Integer.valueOf( tempCustomer.Number_of_Visits__c); 
                tempCustomer.Number_of_Visits__c = visits + 1; 
                
                // add customer to update list
                customersToUpdate.add(tempCustomer);
                
            } // end of if
            else
            {
                // create and add new Customer
            	customerList.add(new Customer__c(Name = order.Name + ' '+ order.Customer_Last_Name__c, Number_of_Visits__c = 1 )); 
            } // end of else
         } // end of for
        
        //update customers
        update  customersToUpdate; 
        
        // insert new customers
        insert customerList; 
        
    } // end of method
    
    public static Customer__c getCustomer(String customerName, List<Customer__c> currentL)
    {
         for(Customer__c cus : currentL)
        {
			if(cus.Name == customerName)
            {
				// return customer object that matches the name              
                return cus;  
            } // end of if
           
        } // end of for
        
        return null; 
    } // end of method
    
   
    
}
@isTest
public class CustomerTriggerTest {
    @isTest static void SingleTest(){
        Customer__c customerOne = new Customer__c(Name = 'Bill', Phone_Number__c = '123-456-7890');
        insert customerOne;
        Customer__c customerTwo = new Customer__c(Name = 'Bill', Phone_Number__c = '123-456-7890');
        Database.SaveResult sr = Database.insert(customerTwo, false);
        Integer numFailed = 0;
        if(!sr.isSuccess()){
            numFailed = 1;
    }
        System.assertEquals(1, numFailed);
    }
    @isTest static void BulkTest() {
        List<Customer__c> testCustomers = new List<Customer__c>();
        List<Customer__c> duplicateCustomers = new List<Customer__c>();
        for(Integer i = 0; i < 200; i++){
            Integer phoneNumber = Integer.valueOf(Math.Random() * 1000000000);	
            testCustomers.add(new Customer__c(Name='Bill ' + i, Phone_Number__c = 'phoneNumber'));            
            duplicateCustomers.add(new Customer__c(Name='Bill ' + i, Phone_Number__c = 'phoneNumber'));
        }
        insert testCustomers;
		List<Database.SaveResult> results = Database.insert(duplicateCustomers, false);
        Integer numFailed = 0;
        for(Database.SaveResult sr : results){
            if(!sr.isSuccess()){
                numFailed += 1;
            }
        }
        System.assertEquals(200, numFailed);
    }
    @isTest static void NegativeTest(){
        boolean result = false;
        Customer__c customerOne = new Customer__c(Name = 'Bill', Phone_Number__c = '123-456-7890');
        insert customerOne;
        try{
            Customer__c customerTwo = new Customer__c(Name = 'Bill', Phone_Number__c = '123-456-7890');
            insert customerTwo;
        } catch(DMLException e) {
			result = true;
		}
        System.assertEquals(true, result);
    }
}
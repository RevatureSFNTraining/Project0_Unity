public class CustomerTriggerHandler {
    //Method checks to see if there already exists a customer record with same name and phone number
    public static List<Customer__c> customerCheck(List<Customer__c> customerCatalog) {
        Set<String> nameCheck = new Set<String>();
        Set<String> phoneNumberCheck = new Set<String>();
        //Loops through customers and adds name and phone number to sets
        for(Customer__c custom: customerCatalog) {
            nameCheck.add(custom.Name);
            phoneNumberCheck.add(custom.Phone_Number__c);
        }
        List<Customer__c> customerList = new List<Customer__c>();
        //Adding to the list records that already exist that has name and phone number match new names and phone numbers
        customerList = [SELECT Name, Phone_Number__c FROM Customer__c WHERE Name IN :nameCheck AND Phone_Number__c IN :phoneNumberCheck];
        //Loops through new records and throws an error when name and phone number match existing name and phone number
        for(Customer__c custom : customerCatalog){
            If(customerList.size() > 0){
                custom.addError('Customer Record already exists. Use Current Record');
            }
            
        }
        return customerCatalog;
    }
}
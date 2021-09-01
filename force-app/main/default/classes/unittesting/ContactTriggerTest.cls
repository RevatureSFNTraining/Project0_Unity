@isTest
private class ContactTriggerTest {

    @TestSetup
    static void makeData() {
        List<Contact> customers = new List<Contact>();
        customers.add(new Contact(FirstName = 'Ben', LastName = 'Steward', Birthdate = Date.newInstance(1980, 2, 16), Email = 'some@email.com'));
        customers.add(new Contact(FirstName = 'John', LastName = 'Warner', Birthdate = Date.newInstance(1967, 6, 2), Email = 'the@email.com'));
        customers.add(new Contact(FirstName = 'Bob', LastName = 'Builder', Birthdate = Date.newInstance(1977, 10, 24), Email = 'bob@email.com'));
        customers.add(new Contact(FirstName = 'Billy', LastName = 'Bob', Birthdate = Date.newInstance(1998, 3, 14), Email = 'billy@email.com'));
        customers.add(new Contact(FirstName = 'Jane', LastName = 'Steward', Birthdate = Date.newInstance(1982, 4, 30), Email = 'some1@email.com'));

        insert customers;
    }

    @isTest static void ageVerifyTest() {
        List<Contact> customers = [SELECT Birthdate FROM Contact];
        Map<Id, Integer> customerAgeMap = ContactTriggerHandler.verifyAges(customers);
        for (integer age : customerAgeMap.values()) {
            System.assert(age >= 21);
        }
    }

    @isTest static void insertTest() {
        List<Contact> customers = new List<Contact>();
        customers.add(new Contact(FirstName = 'Ronald', LastName = 'McDonald', Birthdate = Date.newInstance(1940, 5, 15), Email = 'ronald@mcdonalds.com'));
        customers.add(new Contact(FirstName = 'Burger', LastName = 'King', Birthdate = Date.newInstance(1954, 6, 2), Email = 'bk@burgerking.com'));
        customers.add(new Contact(FirstName = 'Wendy', LastName = 'Wendy', Birthdate = Date.newInstance(1969, 11, 15), Email = 'wendy@wendys.com'));
        insert customers;

        List<Contact> customerDB = [SELECT FirstName, LastName FROM Contact];
        for (Contact customer : customerDB) {
            switch on customer.FirstName {
                when 'Ronald' {
                    System.assertEquals('Ronald', customer.FirstName);
                    System.assertEquals('McDonald', customer.LastName);
                }
                when 'Burger' {
                    System.assertEquals('Burger', customer.FirstName);
                    System.assertEquals('King', customer.LastName);
                }
                when 'Wendy' {
                    System.assertEquals('Wendy', customer.FirstName);
                    System.assertEquals('Wendy', customer.LastName);
                }
            }
        }
    }

    @isTest static void underageCustomerTest() {
        Contact underagedCustomer = new Contact(FirstName = 'Fred', LastName = 'Parker', Birthdate = Date.newInstance(2000, 12, 25), Email = 'badstudent@someschool.edu'); //Just under 21 years old.
        insert underagedCustomer;
    }

    @isTest static void duplicateEmailTest() {
        List<Contact> newCustomers = new List<Contact>();
        newCustomers.add(new Contact(FirstName = 'Caroline', LastName = 'Baker', Birthdate = Date.newInstance(1971, 11, 5), Email = 'caroline@bakersbakery.com'));
        newCustomers.add(new Contact(FirstName = 'Non-suspicious', LastName = 'Person', Birthdate = Date.newInstance(1975, 10, 9), Email = 'some@email.com'));
        newCustomers.add(new Contact(FirstName = 'Luigi', LastName = 'Bertoli', Birthdate = Date.newInstance(1957, 3, 14), Email = 'management@luigispizza.com'));
        insert newCustomers;
    }
}
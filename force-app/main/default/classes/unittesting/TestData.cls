public class TestData {
    
    @TestVisible
    private static List<sObject> getTestData() {
        List<sObject> testDB = new List<sObject>();

        //Account
        insert new Account(Name = 'Test Company');
        Account acc = [SELECT Id FROM Account WHERE Name = 'Test Company'];

        //Contacts
        testDB.add(new Contact(FirstName = 'Ben', LastName = 'Steward', Birthdate = Date.newInstance(1980, 2, 16), Email = 'some@email.com'));
        testDB.add(new Contact(FirstName = 'John', LastName = 'Warner', Birthdate = Date.newInstance(1967, 6, 2), Email = 'the@email.com'));
        testDB.add(new Contact(FirstName = 'Bob', LastName = 'Builder', Birthdate = Date.newInstance(1977, 10, 24), Email = 'bob@email.com'));
        testDB.add(new Contact(FirstName = 'Billy', LastName = 'Bob', Birthdate = Date.newInstance(1998, 3, 14), Email = 'billy@email.com'));
        testDB.add(new Contact(FirstName = 'Jane', LastName = 'Steward', Birthdate = Date.newInstance(1982, 4, 30), Email = 'some1@email.com'));

        //Vehicles
        testDB.add(new Vehicle__c(Name = 'Toyota Camry 2019 Black', Vehicle_Identification_Number__c = 'FAKE1252211242211255', Base_Rental_Rate__c = 40.28, Vehicle_Year__c = 2019, Vehicle_Make__c = 'Toyota', Vehicle_Model__c = 'Camry'));
        testDB.add(new Vehicle__c(Name = 'Honda CRV 2019 Silver', Vehicle_Identification_Number__c = 'FAKE1252218653263121', Base_Rental_Rate__c = 43.28, Vehicle_Year__c = 2019, Vehicle_Make__c = 'Honda', Vehicle_Model__c = 'CRV'));
        testDB.add(new Vehicle__c(Name = 'Lexus ES350 2022 Red', Vehicle_Identification_Number__c = 'FAKE1252283324562268', Base_Rental_Rate__c = 67.39, Vehicle_Year__c = 2022, Vehicle_Make__c = 'Lexus', Vehicle_Model__c = 'ES350'));
        testDB.add(new Vehicle__c(Name = 'Toyota Camry 2019 Black', Vehicle_Identification_Number__c = 'FAKE1252285323767642', Base_Rental_Rate__c = 40.28, Vehicle_Year__c = 2019, Vehicle_Make__c = 'Toyota', Vehicle_Model__c = 'Camry'));

        //Depots
        testDB.add(new Depot__c(Name = 'Test Company Orlando', Owner__c = acc.Id, Address__c = '123 Sesame Street, Orlando FL 32715'));
        testDB.add(new Depot__c(Name = 'Test Company Ontario', Owner__c = acc.Id, Address__c = '64 Fake Street, Ontario CA 92175'));

        return testDB;
    }
}

/*
 * ContactTrigger
 * Author: Wayne He
 * Date Modified: 2021-09-01
 * Description: Unit test class for the vehicle trigger.
 */

 @isTest
private class VehicleTriggerTest {
    
    @TestSetup
    static void makeData(){
        TestData.createTestData();
    }

    @isTest static void addVehicleTest() {
        Vehicle__c newVehicle = new Vehicle__c(Name = 'Toyota Camry 2020 Black', Vehicle_Identification_Number__c = 'FAKE1252211234211255', Base_Rental_Rate__c = 42.61, Vehicle_Year__c = 2020, Vehicle_Make__c = 'Toyota', Vehicle_Model__c = 'Camry');
        insert newVehicle;
    }

    @isTest static void changeStatusTest() {
        List<Vehicle__c> vehicles = [SELECT Status__c FROM Vehicle__c WHERE Status__c != 'Checked Out'];
        vehicles[0].Status__c = 'Checked Out';
        update vehicles[0];
    }

    @isTest static void manualCheckInTest() {
        List<Vehicle__c> vehicles = [SELECT Status__c FROM Vehicle__c WHERE Status__c = 'Checked Out'];
        vehicles[0].Status__c = 'Checked In';
        update vehicles[0];
    }

    @isTest static void manualStationTest() {
        List<Vehicle__c> vehicles = [SELECT Status__c FROM Vehicle__c WHERE Status__c = 'Checked Out'];
        Depot__c depot = [SELECT Id FROM Depot__c LIMIT 1];
        vehicles[0].Stationed_Depot__c = depot.Id;
        update vehicles[0];
    }
}

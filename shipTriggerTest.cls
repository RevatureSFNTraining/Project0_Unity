@isTest
public class shipTriggerTest {
    
    //single, positive test
    @isTest static void testNewShip() {
        Contact owner = new Contact(FirstName = 'John', LastName = 'Smith');
        insert owner;
        Ship__c existingShip = new Ship__c(Name = 'U.S.S. Explorer', Jumps_Made__c = 20, Owner__c = owner.Id);
        insert existingShip;
        Ship__c newShip = new Ship__c(Name = 'U.S.S. Explorer', Jumps_Made__c = 5, Owner__c = owner.Id);
        try{
            insert newShip;
        } catch(Exception ex) {
            list<Ship__c> ships = [SELECT Name, Jumps_Made__c FROM Ship__c ORDER BY Name DESC];
            system.assertEquals('U.S.S. Explorer', ships[0].Name);
            system.assertEquals(20, ships[0].Jumps_Made__c);
            system.assertEquals(1, ships.size());
        }
    }
    
    //bulk and negative test
    @isTest static void testNewShips() {
        //delcare initialize, and insert all test variables
        Contact owner = new Contact(FirstName = 'John', LastName = 'Smith');
        insert owner;
        Ship__c existingShip1 = new Ship__c(Name = 'U.S.S. Explorer', Jumps_Made__c = 20, Owner__c = owner.Id);
        Ship__c existingShip2 = new Ship__c(Name = 'U.S.S. Ishtar', Jumps_Made__c = 15, Owner__c = owner.Id);
        Ship__c existingShip3 = new Ship__c(Name = 'U.S.S. New Horizons', Jumps_Made__c = 32, Owner__c = owner.Id);
        list<Ship__c> oldShips = new list<Ship__c>();
        oldShips.add(existingShip1);
        oldShips.add(existingShip2);
        oldShips.add(existingShip3);
        
        Ship__c newShip1 = new Ship__c(Name = 'U.S.S. Ishtar', Jumps_Made__c = 2, Owner__c = owner.Id);
        Ship__c newShip2 = new Ship__c(Name = 'U.S.S. Bounty', Jumps_Made__c = 4, Owner__c = owner.Id);
        Ship__c newShip3 = new Ship__c(Name = 'U.S.S. New Horizons', Jumps_Made__c = 3, Owner__c = owner.Id);
        list<Ship__c> newShips = new list<Ship__c>();
        newShips.add(newShip1);
        newShips.add(newShip2);
        newShips.add(newShip3);
        insert oldShips;
        
        //attempt to insert new ships, some with duplicate names
        try {
            database.insert(newShips, false);
        } catch(Exception ex) {
            list<Ship__c> testShips = [SELECT Name, Jumps_Made__c FROM Ship__c ORDER BY Name DESC];
            system.assertEquals(4, testShips.size());
            system.assertEquals('U.S.S. Bounty', testShips[0].Name);
            system.assertEquals('U.S.S. Explorer', testShips[1].Name);
            system.assertEquals('U.S.S. Ishtar', testShips[2].Name);
            system.assertEquals('U.S.S. New Horizons', testShips[3].Name);
        }
    }
    
    //user restricted
}
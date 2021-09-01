public class shipTriggerHandler {
    //if ship name already exists, can't add new ship
    public shipTriggerHandler(list<Ship__c> newShips) {
        list<Ship__c> ships = [SELECT Id, Name FROM Ship__c];
        for(integer i = 0; i < newShips.size(); i++) {
            for (integer a = 0; a < ships.size(); a++) {
                if (newShips[i].Name == ships[a].Name) {
                    newShips[i].addError('That ship name is already taken.');
                }
            }
        }
    }
}
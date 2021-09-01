public class TransactionTriggerHandler {
    public static List<Transaction__c> updatedInventory(List<Transaction__c> purchases) { 
        //Searches through all items in Inventory
        List<Inventory__c> currentInventory = [SELECT id, Quantity__c FROM Inventory__c];
        for(Transaction__c trans : purchases) {
            //Loops through all current inventory products
            for(Integer i = 0; i < currentInventory.size(); i++){
                Inventory__c inventoryStock = currentInventory[i];
            		//Checks if product Id in inventory is the same as product item in Transaction and updates inventory quantity
                if(inventoryStock.Id == trans.Inventory__c){
                		inventoryStock.Quantity__c = inventoryStock.Quantity__c - trans.Quantity__c;
            }
          }
        }
        update currentInventory;
        return purchases;
    }
	
}
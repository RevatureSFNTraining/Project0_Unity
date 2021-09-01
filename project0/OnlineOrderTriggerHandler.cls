public class OnlineOrderTriggerHandler {
    //Method checks to see if there is enough product in Inventory to complete an online order
    public static List<Online_Order__c> checkForInventory(List<Online_Order__c> onlineOrder){
        Map<id, Decimal> existingInventoryMap = new Map<id, Decimal>(); 
        List<Inventory__c> inventoryProducts = [SELECT id, Quantity__c FROM Inventory__c];
        for(Online_Order__c order : onlineOrder) {
            //Loops through the Inventory to check for matching Id between product ordered online and inventory product
            for(Integer i = 0;i < inventoryProducts.size(); i++){
                Inventory__c inventoryItem = inventoryProducts[i];
                if(inventoryItem.Id == order.Inventory__c){
                    existingInventoryMap.put(inventoryItem.id, inventoryItem.Quantity__c);
                }                
            }
        }
        //Checks to see if the quantity of product ordered is greater than the amount in Inventory and throws error if true
        for(Online_Order__c order : onlineOrder) {
          	Decimal lessProduct = existingInventoryMap.get(order.Inventory__c);
            if(Integer.valueOf(order.Quantity__c) > lessProduct){
                order.addError('Not enough product in Inventory.');
            }
               //Updates amount in Inventory for next online order in the loop
               else{
                   existingInventoryMap.put(order.Inventory__c, lessProduct - Integer.valueOf(order.Quantity__c)); 
               }
        
         }
        return onlineOrder;    
    }

               }
public class RentalContractTriggerHandler {
    
    public static void checkCustomersForOverdueVehicles(List<Rental_Contract__c> contracts) {
        //Get customers from the list of contracts.
        Set<Id> customers = new Set<Id>();
        for (Rental_Contract__c rentalContract : contracts) {
            customers.add(rentalContract.Customer__c);
        }
        
        //Fetch overdue contracts.
        integer overdueContracts = [SELECT COUNT() FROM Rental_Contract__c WHERE Customer__c IN :customers AND Status__c = 'Overdue'];
        if (overdueContracts > 0) {
            contracts[0].addError('Customer has an overdue contract. Please resolve this before creating a new contract.');
        }
        
    }

    public static void checkOutVehicle(List<Rental_Contract__c> contracts) {
        Map<Id, Vehicle__c> vehicleMap = getVehicleMap(contracts);
        
        //Iterate through each contract.
        for (Rental_Contract__c rentalContract : contracts) {
            //Check if the contract's associated vehicle is checked in. Abort if it is not.
            if (vehicleMap.get(rentalContract.Vehicle__c).Status__c.equals('Checked Out'))
                rentalContract.Vehicle__c.addError('Vehicle is not available for checking out.');
            
            //Check if the contract's issue date is later than current date. Abort if it is.
            if (rentalContract.Issue_date__c.daysBetween(Date.today()) < 0)
                rentalContract.Issue_Date__c.addError('Cannot issue a contract that starts at a later date than today.');
            
            //Check if the contract's expected return date is earlier than or the same as the issue date. Abort if it is.
            if (rentalContract.Expected_Return_Date__c.daysBetween(rentalContract.Issue_Date__c) >= 0)
                rentalContract.Expected_Return_Date__c.addError('Cannot issue a contract with an expected return date earlier than or at the issue date.');
        }
    }
    
    public static void checkReturnDate(List<Rental_Contract__c> contracts) {
        //Check if the actual return date takes place before the issue date. Abort if this is true.
        for (Rental_Contract__c rentalContract : contracts) {
            //Skip null values.
            if (rentalContract.Actual_Return_Date__c == null)
                continue;
            
            if (rentalContract.Actual_Return_Date__c.daysBetween(rentalContract.Issue_Date__c) > 0)
                rentalContract.Actual_Return_Date__c.addError('Return date cannot occur before the issue date.');
        }
    }
    
    public static void changeVehicleStatus(List<Rental_Contract__c> contracts, boolean isCheckingOut) {
        Map<Id, Vehicle__c> vehicleMap = getVehicleMap(contracts);
        
        //Set status of each vehicle.
        for (Vehicle__c vehicle : vehicleMap.values()) {
            if (isCheckingOut) {
                vehicle.Status__c = 'Checked Out';
                vehicle.Stationed_Depot__c = null;
            }
            else {
                vehicle.Status__c = 'Checked In';
            }
            
        }
        
        //Attempt to update entries.
        try {
            update vehicleMap.values();
        } catch (DMLException e) {
            contracts[0].addError(e);
        }
    }
    
    public static void postponeCheck(List<Rental_Contract__c> oldContracts, List<Rental_Contract__c> newContracts) {
        //Compare expected return dates for the two lists. If the new deadline is earlier than the old one, abort the update.
        for (integer i = 0; i < oldContracts.size(); i++) {
            if (oldContracts[i].Expected_Return_Date__c.daysBetween(newContracts[i].Expected_Return_Date__c) < 0)
                newContracts[i].Expected_Return_Date__c.addError('Cannot set the expected return date earlier than the current deadline: ' + oldContracts[i].Expected_Return_Date__c);
        }
    }
    
    private static Map<Id, Vehicle__c> getVehicleMap(List<Rental_Contract__c> contracts) {
        //Get vehicles from contract list. Abort if there are duplicates.
        Set<Id> vehicleIds = new Set<Id>();
        for (Rental_Contract__c rentalContract : contracts) {
            if (!vehicleIds.contains(rentalContract.Vehicle__c))
                vehicleIds.add(rentalContract.Vehicle__c);
            else
                rentalContract.Vehicle__c.addError('Can only form a single contract with a checked out vehicle once.');
        }
        List<Vehicle__c> vehicles = [SELECT Id, Status__c FROM Vehicle__c WHERE Id IN :vehicleIds];
        return new Map<Id, Vehicle__c>(vehicles);
    }
}
public class ContactTriggerHandler {

    public static Map<Id, integer> verifyAges(List<Contact> customers) {
        Map<Id, integer> customerAgeMap = new Map<Id, integer>();

        //Check if the customers are above 21 years old.
        for (Contact customer : customers) {
            integer age = Math.abs(Date.today().daysBetween(customer.Birthdate));

            //There is an average of 365.25 days per year in a period of 4 years.
            //This is because there is a leap year every 4 years, which adds an extra day.
            if (age < (21 * 365.25))
                customer.Birthdate.addError('Customer is not 21 years of age or above.');

            customerAgeMap.put(customer.Id, age);
        }

        return customerAgeMap;
    }
    
    public static void checkForDuplicateEmails(List<Contact> customers) {
        //Get E-mails from database and check for duplicates.
        List<Contact> customerDB = [SELECT Id, Email FROM Contact];
        for (Contact customerToEdit : customers) {
            for (Contact customerInDB: customerDB) {
                if (customerToEdit.Email.equals(customerInDB.Email))
                    customerToEdit.Email.addError('A contact with this e-mail already exists.');
            }
        }
    }
}
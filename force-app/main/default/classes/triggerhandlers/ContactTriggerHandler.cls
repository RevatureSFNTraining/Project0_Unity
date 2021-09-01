public class ContactTriggerHandler {

    public static Map<Id, boolean> verifyAges(List<Contact> customers) {
        Map<Id, boolean> customerLegalAgeCheckMap = new Map<Id, boolean>();

        //Check if the customers are above 21 years old.
        for (Contact customer : customers) {
            boolean isLegalAge = checkLegalAge(customer.Birthdate);
            if (!isLegalAge)
                customer.Birthdate.addError('Customer is not 21 years of age or above.');

            

            customerLegalAgeCheckMap.put(customer.Id, isLegalAge);
        }

        return customerLegalAgeCheckMap;
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

    private static boolean checkLegalAge(Date birthDate) {
        Date today = Date.today();
        
        //Verify age by comparing year, month, and day.
        integer yearDifference = today.year() - birthDate.year();
        if (yearDifference < 21)
            return false;
        else if (yearDifference == 21) {
            //Check month next.
            integer monthDifference = today.month() - birthDate.month();
            if (monthDifference < 0)
                return false;
            else if (monthDifference == 0) {
                //Check day.
                integer dayDifference = today.day() - birthDate.day();
                if (dayDifference < 0)
                    return false;
            }
        }

        return true;
    }
}
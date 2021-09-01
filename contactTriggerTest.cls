@isTest
public class contactTriggerTest {
    //single/positive
    @isTest static void testRevive() {
        //create record to delete and attempt to create record with same email
        Contact oldGuy = new Contact(FirstName = 'John', LastName = 'Smith', Email = 'jsmith@revature.net');
        insert oldGuy;
        delete oldGuy;
        Contact newGuy = new Contact(FirstName = 'James', LastName = 'Smith', Email = 'jsmith@revature.net');
        try {
        	insert newGuy;
        } catch(Exception ex) {
        
        	//get all current Contacs and print out their data
        	list<Contact> customers = [SELECT Id, Email, Name, IsDeleted FROM Contact ALL ROWS];
        	for (integer i = 0; i < customers.size(); i++) {
            	system.debug('Name: ' + customers[i].Name + ' Email: ' + customers[i].Email + ' isDeleted: ' + customers[i].IsDeleted);
        	}
        
        	//validate data
        	system.assertEquals('John Smith', customers[0].Name);
        	system.assertEquals('jsmith@revature.net', customers[0].Email);
        	system.assertEquals(1, customers.size());
        }
    }
    
    //bulk/negative
    @isTest static void massRevival() {
        //declare and initialize all old/deleted customers
        Contact oldGuy1 = new Contact(FirstName = 'John', LastName = 'Smith', Email = 'jsmith@revature.net');
        Contact oldGuy2 = new Contact(FirstName = 'Jane', LastName = 'Smith', Email = 'jane.smith@revature.net');
        Contact oldGuy3 = new Contact(FirstName = 'Chris', LastName = 'Smith', Email = 'smithc@revature.net');
        list<Contact> oldGuys = new list<Contact>();
        oldGuys.add(oldGuy1);
        oldGuys.add(oldGuy2);
        oldGuys.add(oldGuy3);
        insert oldGuys;
        delete oldGuys;
        //declare and initialize all new customers, with some copies
        Contact newGuy1 = new Contact(FirstName = 'Joan', LastName = 'Smith', Email = 'jsmith@revature.net');
        Contact newGuy2 = new Contact(FirstName = 'Jordan', LastName = 'Smith', Email = 'jordan.smith@revature.net');
        Contact newGuy3 = new Contact(FirstName = 'Colton', LastName = 'Smith', Email = 'smithc@revature.net');
        list<Contact> newGuys = new list<Contact>();
        newGuys.add(newGuy1);
        newGuys.add(newGuy2);
        newGuys.add(newGuy3);

        //try to insert new customers, with some copies, and verify results
        try {
        	database.insert(newGuys, false);
        } catch(Exception ex) {
            list<Contact> allGuys = [SELECT Name, Email FROM Contact ORDER BY Name DESC ALL ROWS];
            system.assertEquals('Chris Smith', allGuys[0].Name);
            system.assertEquals('Jane Smith', allGuys[1].Name);
            system.assertEquals('John Smith', allGuys[2].Name);
            system.assertEquals('Jordan Smith', allGuys[3].Name);
            system.assertEquals(4, allGuys.size());
        }
        
        
    }
}
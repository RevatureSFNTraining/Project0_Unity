@isTest
private class caseTriggerTest {
    //single and positive test
    @isTest static void testTicketAssignment() {
        //create employee for valid name
        Employee__c newEmployee = new Employee__c(Name = 'John Smith', Department__c = 'Engine Specialist', Salary__c = 10000);
        insert newEmployee;
        
        //create old ticket and new tickets
        Case oldTicket = new Case(assigned_Employee__c = 'John Smith');
        list<Case> newTickets = new list<Case>();
        newTickets.add(new Case(Priority = '1', assigned_Employee__c = 'None'));
        newTickets.add(new Case(Priority = '3', assigned_Employee__c = 'None'));
        insert oldTicket;
        insert newTickets;
        oldTicket.status = 'closed';
        update oldTicket;

        //print out results
        newTickets = [SELECT CaseNumber, Assigned_Employee__c, Priority, Status FROM Case WHERE Status != 'closed' ORDER BY Priority ASC];
        for(integer i = 0; i < newTickets.size(); i++)
            system.debug('Case #: ' + newTickets[i].caseNumber + ' Assigned Employee: ' + newTickets[i].assigned_Employee__c + ' Priority: ' + newTickets[i].priority);
        
        //assert statements
        system.debug('Expect true for all following tests:');
        system.assertEquals('John Smith', newTickets[0].assigned_Employee__c);
        system.assertEquals('None', newTickets[1].assigned_Employee__c);
        system.assertEquals(newTickets.size(), 2);
    }

    //bulk and positive test
    @isTest static void testBulkTicketAssignment() {
        //add employees for valid names
        Employee__c newEmployee1 = new Employee__c(Name = 'John Doe', Department__c = 'Engine Specialist', Salary__c = 10000);
        Employee__c newEmployee2 = new Employee__c(Name = 'Jane Doe', Department__c = 'Engine Specialist', Salary__c = 10000);
        Employee__c newEmployee3 = new Employee__c(Name = 'Chris Doe', Department__c = 'Engine Specialist', Salary__c = 10000);
        list<Employee__c> newEmployees = new list<Employee__c>();
        newEmployees.add(newEmployee1);
        newEmployees.add(newEmployee2);
        newEmployees.add(newEmployee3);
        insert newEmployees;
        
        //create current tickets being worked on
        Case oldTicket1 = new Case(assigned_Employee__c = 'John Doe');
        Case oldTicket2 = new Case(assigned_Employee__c = 'Jane Doe');
        Case oldTicket3 = new Case(assigned_Employee__c = 'Chris Doe');
        list<Case> oldTickets = new list<Case>();
        oldTickets.add(oldTicket1);
        oldTickets.add(oldTicket2);
        oldTickets.add(oldTicket3);
        insert oldTickets;
        
        //create new tickets to assign workers to when their case closes, and set old ticket status to closed
        list<Case> newTickets = new list<Case>();
        for (integer i = 0; i < 5; i++) {
            integer num = Math.mod(i, 3);
            newTickets.add(new Case(Priority = (num + 1) + '', assigned_Employee__c = 'None'));
            if (i < 3)
                oldTickets[i].status = 'closed';
        }
        insert newTickets;
        update oldTickets;

        //print out results
        newTickets = [SELECT CaseNumber, Assigned_Employee__c, Priority FROM Case WHERE Status != 'closed' ORDER BY Priority ASC];
        for(integer a = 0; a < newTickets.size(); a++)
            system.debug('Case #: ' + newTickets[a].caseNumber + ' Assigned Employee: ' + newTickets[a].assigned_Employee__c + ' Priority: ' + newTickets[a].priority);

        //verify each new ticket has the correct assigned employee/any assigned employee
        system.debug('\n Expect true for following statements:');
        system.assertEquals('John Doe', newTickets[0].assigned_Employee__c);
        system.assertNotEquals('None', newTickets[1].assigned_Employee__c);
        system.assertNotEquals('None', newTickets[2].assigned_Employee__c);
        system.assertEquals('None', newTickets[3].assigned_Employee__c);
        system.assertEquals('None', newTickets[4].assigned_Employee__c);
        system.assertEquals(5, newTickets.size());
    }

    //negative test (fails due to no employee object with same name)
    @isTest static void testNegative() {
        Case oldTicket = new Case(assigned_Employee__c = 'Alex Bashaw');
        insert oldTicket;
        oldTicket.status = 'closed';
        update oldTicket;
    }
}
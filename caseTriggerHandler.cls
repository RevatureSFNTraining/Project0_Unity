public class caseTriggerHandler {
	public caseTriggerHandler(list<Case> newCase) {
        //assign employee from closed case a new case
        for (Case ticket:newCase){
            //check to verify if ticket name is a valid employee name
            list<Employee__c> employeeNames = [SELECT Name FROM Employee__c];
            boolean badName = true;
            for (integer i = 0; i < employeeNames.size(); i++) {
                if (ticket.Assigned_Employee__c == employeeNames[i].Name)
                    badName = false;
            }
            if (badName)
                ticket.addError('That is not a valid Employee name.');
                
            //assign new ticket to employee when their current ticket is closed.
        	if (ticket.status == 'closed') {
            	String worker = ticket.assigned_Employee__c;
            	list<Case> tickets = [SELECT CaseNumber, Assigned_Employee__c, Priority FROM Case WHERE Assigned_Employee__c = 'None' ORDER BY Priority ASC];
                if (tickets.size() > 0) {
                	tickets[0].assigned_Employee__c = worker;
                    update tickets[0];
                }
        	}
        }
    }
}
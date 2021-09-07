@isTest
private class SeatSelectTriggerTest {
	//single test has a positive test result
    @isTest static void SingleSeatSelectTest(){
        Plane_Ticket__c t = new Plane_Ticket__c(Seat_Selection__c='General Seat');
        
        insert t;
        
        Database.SaveResult sr = Database.insert(t);
        Integer numFailed = 0;
        SeatSelectTriggerHandler g = new SeatSelectTriggerHandler();
        Test.startTest();
        if(!sr.isSuccess()){
            numFailed = 1;
            Test.stoptest();
        }
        
       
    }

    @isTest static void BulkSeatSelectTriggerTest() {
        
        
        Plane_Ticket__c t2 = new Plane_Ticket__c(Ticket_Price__c=400, Seat_Selection__c='General Seat'); 
        
    		for(integer b=0; b<21; b++) {
            	if(b < 21){
        insert t2;
            }
        }
        Database.SaveResult sr = Database.insert(t2);
        Integer numFailed = 0;
        Test.startTest();
        
        if(!sr.isSuccess()){
            numFailed = 1;
            Test.stoptest();
        }
      
    }

@isTest public Static Void RestrictedUserSeatSelectionTest(){
        String uN1 = 'user';
        profile RU = [SELECT id FROM Profile Where name='Passangers'];
        
        User U1 = new User(alias = 'testUser2', email='testuser2@Jordan.com',
                          emailencodingkey='UTF-8', lastname = 'Test', languagelocalekey='en_us',
                          timezonesidkey='america/new_york', localeSidKey='en_us', 
                          profileId=RU.id, username=uN1);
        
        System.Runas(U1) {
            System.debug(UserInfo.getUserName());
            System.debug(UserInfo.GetProfileId());
            System.debug('Restricted User Test');
        }
    }
    

 @isTest static void NegativeFlightCrewTest(){
        Plane_Ticket__c t = new Plane_Ticket__c(Ticket_Price__c=220, Seat_Selection__c='Exit Row Seat (More legroom)');
        insert t;
        
        Plane_Ticket__c C = new Plane_Ticket__c(Ticket_Price__c=220, Seat_Selection__c='First Class Comfort (Extra leg room, Reclines)');
        insert C;
        
        Database.SaveResult sr = Database.insert(t);
        Integer numFailed = 0;
        
        Database.SaveResult sr2 = Database.insert(C);
        Integer numFailed2 = 0;
     Test.startTest();
        
        if(!sr.isSuccess()){
            numFailed = 1;
            if(!sr2.isSuccess()){
            numFailed2 = 1;
                Test.stoptest();
        }
        }
      
    }

}
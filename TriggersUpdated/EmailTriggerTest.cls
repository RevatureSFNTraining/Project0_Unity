@isTest private class emailTriggerTest {
	//single test has a positive test result
    @isTest static void SingleEmailTest() {
        Passanger_Accounts__c t = new Passanger_Accounts__c(Name='TestPassenger', Last_Name__c= 'testLastName', email__c='test1passanger@passenger.com', Passenger_Phone_number__c='123456789', Address__c= 'Not too far away');
        
        insert t;
        
        Database.SaveResult sr = Database.insert(t);
        Integer numFailed = 0;
        emailTriggerHandler g = new emailTriggerHandler();
        Test.startTest();
        if(!sr.isSuccess()){
            numFailed = 1;
            Test.stoptest();
            system.assertEquals(1, numFailed);
        }
        
       
    }
    @isTest static void BulkEmailTest(){
        Passanger_Accounts__c t = new Passanger_Accounts__c(Name='TestPassanger', Last_Name__c= 'testLastName', email__c='testpassanger@passanger.com', Passenger_Phone_number__c='123456789', Address__c= 'Not too far away');
        List<Passanger_Accounts__c> testlist = new List<PAssanger_Accounts__c>();
        for(integer b=0; b<200; b++) {
            if(b < 200){
                testlist.add(t);
        insert t;
            }
        }
        Database.SaveResult sr = Database.insert(t);
        Integer numFailed = 0;
        Test.startTest();
        
        if(!sr.isSuccess()){
            numFailed += 1;
            Test.stoptest();
        }
      
    }
    

@isTest public Static Void RestrictedUserEmailTest() {
        String uN1 = 'user';
        profile RU = [SELECT id FROM Profile Where name='Standard User'];
        
        User U1 = new User(alias = 'testUser', email='testuser@Jordan.com',
                          emailencodingkey='UTF-8', lastname = 'Test', languagelocalekey='en_us',
                          timezonesidkey='america/new_york', localeSidKey='en_us', 
                          profileId=RU.id, username=uN1);
        Test.starttest();
        System.Runas(U1) {
            System.debug(UserInfo.getUserName());
            System.debug(UserInfo.GetProfileId());
            System.debug('Restricted User Test');
            Test.stoptest();
        }
}
    

 @isTest static void NegativeEmailTest(){
     
     try {
         for (Passanger_Accounts__c t = new Passanger_Accounts__c(Name='TestPassanger', Passenger_Phone_number__c='123456789', Address__c= 'Not too far away');;){
           System.debug('Sorry this ticket is unavailable');
             insert t;
                 System.debug('There was and error in your credentials please try again.');
             }
         
             
             }catch(Exception a) { 
                 Passanger_Accounts__c t = new Passanger_Accounts__c(Passenger_Phone_number__c='00'); {
                 System.debug('Please enter a valid Phone Number.');
                     }
                 
             }

        }
        }